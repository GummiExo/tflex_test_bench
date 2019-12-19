clear all; clc; close all;
addpath('src/')
cd data/chirp_response/
files = dir('*.mat');

%% Plot Data: If the variable is 1 the plots are activated
plot_all_trials = 0; 
plot_cut_trials = 0;
plot_goal_presente_angle = 0;
plot_bode = 0;

%Parameters
column_subplot = 4;

%% Load Data
for i=1:length(files)
   data = load(files(i).name);
   chirp_trials(i).motor_states_frontal = data.motor_states_frontal;
   chirp_trials(i).motor_states_posterior = data.motor_states_posterior;
   chirp_trials(i).load_data = data.load_data;
   chirp_trials(i).Trial = deal(files(i).name(1:end-4));
end

clear data i files;

%% Adjust Trials Name
for i = 1:length(chirp_trials)
    chirp_trials(i).Trial = strrep(chirp_trials(i).Trial,'_',' ');
    % Chirp Response 3 = 0.1 rad
    if ~isempty(strfind(chirp_trials(i).Trial,'chirp response3')) == 1
        chirp_trials(i).Trial = strrep(chirp_trials(i).Trial,'chirp response3','chirp response 0.05 rad');
    % Chirp Response 2 = 0.2 rad
    elseif ~isempty(strfind(chirp_trials(i).Trial,'chirp response2')) == 1
        chirp_trials(i).Trial = strrep(chirp_trials(i).Trial,'chirp response2','chirp response 0.2 rad');
    % Chirp Response 1 = 0.1 rad
    else 
        chirp_trials(i).Trial = strrep(chirp_trials(i).Trial,'chirp response','chirp response 0.1 rad');
    end
end

%% Interpolation
for i=1:length(chirp_trials)
   [chirp_trials(i).interp.load_data,chirp_trials(i).interp.motor_frontal,chirp_trials(i).interp.motor_posterior] = interpolation3dat(chirp_trials(i).load_data,chirp_trials(i).motor_states_frontal,chirp_trials(i).motor_states_posterior);
end

%% Cut Data

for i = 1:length(chirp_trials)
   %Initial and Final Positions
   init_vector = intersect(find(chirp_trials(i).interp.motor_frontal.Goal_Angle ~= 0),find(isnan(chirp_trials(i).interp.motor_frontal.Goal_Angle) == 0)) - 1;
   init_pos = init_vector(1);
   final_pos = find( diff(chirp_trials(1).motor_states_frontal.Goal_Angle(init_pos:end),120)==0,1) + init_pos - 1;
   
   chirp_data(i).m1_goal = chirp_trials(i).interp.motor_frontal.Goal_Angle(init_pos:final_pos);
   chirp_data(i).m1_present = chirp_trials(i).interp.motor_frontal.Present_Angle(init_pos:final_pos);
   chirp_data(i).m2_goal = chirp_trials(i).interp.motor_posterior.Goal_Angle(init_pos:final_pos);
   chirp_data(i).m2_present = chirp_trials(i).interp.motor_posterior.Present_Angle(init_pos:final_pos);
   chirp_data(i).torque = chirp_trials(i).interp.load_data.filtered(init_pos:final_pos);
   chirp_data(i).timestamp = chirp_trials(i).interp.load_data.Timestamp(init_pos:final_pos);
   chirp_data(i).frequencies(:,1) = linspace(0,10,length(chirp_data(i).timestamp));
   chirp_data(i).delta_f =  chirp_data(i).frequencies(2,1) - chirp_data(i).frequencies(1,1);
   chirp_data(i).Trial = chirp_trials(i).Trial;
end

clear init_* final_pos;

%% System Identification
%tfest options
opt = tfestOptions;
opt.InitializeMethod = 'all';
opt.SearchOptions.MaxIterations = 20;
%opt.Focus = 'simulation';
opt.Display = 'off';

for i = 1:length(chirp_data)
    %Sample Time 
    for j = 2:length(chirp_data(i).timestamp)
        sample_time_vector(j-1) = (chirp_data(i).timestamp(j) - chirp_data(i).timestamp(j-1));
    end
    sample_time = mean(sample_time_vector);
    
    gs(i).Trial = chirp_data(i).Trial;
    gs(i).sample_time = sample_time;
    
    opt.InitializeMethod = 'all';
    
    %Frontal Motor Model
    data = iddata(chirp_data(i).m1_present,chirp_data(i).m1_goal,sample_time);
    gs(i).model.frontal_motor = tfest(data,3,0,'Ts',sample_time,opt);
    gs(i).bandwidth.model_frontal_motor = bandwidth(gs(i).model.frontal_motor)/(2*pi);
    
    %Verify Model
    %compare(data,gs(i).model_frontal_motor)
    
    
    %Posterior Motor Model
    data = iddata(chirp_data(i).m2_present,chirp_data(i).m2_goal,sample_time);
    gs(i).model.posterior_motor = tfest(data,3,0,'Ts',sample_time,opt); 
    gs(i).bandwidth.model_posterior_motor = bandwidth(gs(i).model.posterior_motor)/(2*pi);
    
    %Verify Model
    %compare(data,gs(i).model_frontal_motor) 
    
 
    %Torque - Angle Model
    data = iddata(chirp_data(i).torque,[-chirp_data(i).m1_present -chirp_data(i).m2_present],sample_time);
    gs(i).model.angle_torque = tfest(data,[10 10],[3 3],'Ts',sample_time,opt);
    tf1 = tf(gs(i).model.angle_torque.Structure(1,1).Numerator.Value,gs(i).model.angle_torque.Structure(1,1).Denominator.Value,sample_time);
    tf2 = tf(gs(i).model.angle_torque.Structure(1,2).Numerator.Value,gs(i).model.angle_torque.Structure(1,2).Denominator.Value,sample_time);
    gs(i).bandwidth.angle_torque = [bandwidth(tf1)/(2*pi) bandwidth(tf2)/(2*pi)];
    
end

clear data sample* i j opt;

%% Model Verification

for i = 1:length(gs)
    %%Motors Model
   if gs(i).model.frontal_motor.Report.Fit.FitPercent < 75 
       msg = ['Model not adjusted: ' gs(i).Trial '\nFit Percentage Frontal Motor: ' num2str(gs(i).model.frontal_motor.Report.Fit.FitPercent)];
       warning('MyComponent:incorrectType',msg)
       gs(i).model.frontal_motor = NaN;
       gs(i).bandwidth.model_frontal_motor = 0;
   end 
   if gs(i).model.posterior_motor.Report.Fit.FitPercent < 75
       msg = ['Model not adjusted: ' gs(i).Trial '\nFit Percentage Posterior Motor: ' num2str(gs(i).model.posterior_motor.Report.Fit.FitPercent)];
       warning('MyComponent:incorrectType',msg)
       gs(i).model.posterior_motor = NaN;
       gs(i).bandwidth.model_posterior_motor = 0;
   end
   if gs(i).model.angle_torque.Report.Fit.FitPercent < 75
       msg = ['Model not adjusted: ' gs(i).Trial '\nFit Percentage Angle-Torque: ' num2str(gs(i).model.angle_torque.Report.Fit.FitPercent)];
       warning('MyComponent:incorrectType',msg)
       gs(i).model.angle_torque = NaN;
       gs(i).bandwidth.angle_torque = [0 0];
   end

end
clear msg i;

%% Bandwidth Ao = Ai*0.5012

for i = 1:length(chirp_data)    
    [peaks pos_peaks] = findpeaks(chirp_trials(i).load_data.filtered);
    max_peak = max(peaks);
    pos_max_peak_vector = find(peaks == max_peak);
    pos_max_peak = pos_peaks(pos_max_peak_vector);

    limit_amp = max_peak*10^(-3/10);
    limit_amp_pos = pos_peaks(find(peaks(pos_max_peak_vector:end) <= limit_amp,1));
end

%% Plots

if plot_all_trials == 1
    j = 0;
    for i = 1:length(chirp_trials)
       if (i-1) == column_subplot*j || i == 1
           j = j+1;
           figure;
           k = 1;
       end
       subplot(column_subplot,1,k); plot(chirp_trials(i).interp.load_data.Timestamp,chirp_trials(i).interp.load_data.filtered); hold on; plot(chirp_trials(i).interp.motor_frontal.Timestamp,-chirp_trials(i).interp.motor_frontal.Present_Angle);
       title(chirp_trials(i).Trial,'Interpreter', 'none'); legend('Ankle Load','Motors Goal Angle')
       k = k+1;
    end
end

if plot_cut_trials == 1
    j = 0;
    for i = 1:length(chirp_trials)
       if (i-1) == column_subplot*j || i == 1
           j = j+1;
           figure
           k = 1;
       end
       subplot(column_subplot,1,k); plot(chirp_data(i).timestamp,chirp_data(i).y); hold on; plot(chirp_data(i).timestamp,chirp_data(i).u_present);
       title(chirp_trials(i).Trial,'Interpreter', 'none'); legend('Ankle Load','Motors Goal Angle')
       k = k+1;
    end
end

if plot_goal_presente_angle == 1
    j = 0;
    for i = 1:length(chirp_trials)
       if (i-1) == column_subplot*j || i == 1
           j = j+1;
           figure;
           k = 1;
       end
       subplot(column_subplot,1,k); plot(chirp_trials(i).motor_states_frontal.Timestamp,chirp_trials(i).motor_states_frontal.Goal_Angle); hold on; plot(chirp_trials(i).motor_states_frontal.Timestamp,chirp_trials(i).motor_states_frontal.Present_Angle);
                                    plot(chirp_trials(i).motor_states_posterior.Timestamp,chirp_trials(i).motor_states_posterior.Goal_Angle); plot(chirp_trials(i).motor_states_posterior.Timestamp,chirp_trials(i).motor_states_posterior.Present_Angle);
       title(chirp_trials(i).Trial,'Interpreter', 'none'); legend('Frontal Motor Goal Angle','Frontal Motor Present Angle','Posterior Motor Goal Angle','Posterior Motor Present Angle');
       k = k+1;
    end
end

if plot_bode == 1
    j = 0;
    opts = bodeoptions('cstprefs');
    opts.FreqUnits = 'Hz';
    opts.Xlim = [0,10];
    all_trials_plot = figure;
    legend_vector = '';
    for i = 1:length(gs)
       figure(all_trials_plot);
       bode(gs(i).frontal_response,opts); hold on;
       if (i-1) == column_subplot*j || i == 1
           j = j+1;
           bode_plots(j) = figure;
           k = 1;
       end
       legend_vector = [legend_vector; {chirp_trials(i).Trial}];
       figure(bode_plots(j));
       subplot(column_subplot,1,k); bode(gs(i).frontal_response,opts); hold on;
                                    title(gs(i).Trial,'Interpreter', 'none'); 
                                    k = k+1;
    end
    figure(all_trials_plot); legend(legend_vector);
end


clear i j k column_subplot *plot* opts;