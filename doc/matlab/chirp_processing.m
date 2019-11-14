clear all; clc; close all;
addpath('src/')
cd data/chirp_response/
files = dir('*.mat');

%% Plot Data: If the variable is 1 the plots are activated
plot_all_trials = 0; 
plot_cut_trials = 1;
plot_goal_presente_angle = 0;
plot_bode = 1;
%Parameters
column_subplot = 4;

%% Load Data
for i=1:length(files)
   data = load(files(i).name);
   chirp_trials(i).motor_states_frontal = data.motor_states_frontal;
   chirp_trials(i).motor_states_posterior = data.motor_states_posterior;
   chirp_trials(i).load_data = data.load_data;
   chirp_trials(i).Trial = deal(files(i).name);
end

clear data i files;

%% Interpolation
for i=1:length(chirp_trials)
   [chirp_trials(i).interp.load_data,chirp_trials(i).interp.motor_frontal,chirp_trials(i).interp.motor_posterior] = interpolation3dat(chirp_trials(i).load_data,chirp_trials(i).motor_states_frontal,chirp_trials(i).motor_states_posterior);
end

%% Cut Data

for i = 1:length(chirp_trials)
   init_vector = intersect(find(chirp_trials(i).interp.motor_frontal.Goal_Angle ~= 0),find(isnan(chirp_trials(i).interp.motor_frontal.Goal_Angle) == 0)) - 1;
   init_pos = init_vector(1);
   final_pos = find( diff(chirp_trials(1).motor_states_frontal.Goal_Angle(init_pos:end),120)==0,1) + init_pos - 1;
   chirp_data(i).u = -chirp_trials(i).interp.motor_frontal.Present_Angle(init_pos:final_pos);
   chirp_data(i).y = chirp_trials(i).interp.load_data.filtered(init_pos:final_pos);
   chirp_data(i).timestamp = chirp_trials(i).interp.load_data.Timestamp(init_pos:final_pos);
   chirp_data(i).Trial = chirp_trials(i).Trial;
end

clear init_* final_pos;

%% Plant Estimated
for i = 1:length(chirp_data)
    data = iddata(chirp_data(i).y,chirp_data(i).u ,1/120);
    gs(i).function = etfe(data,2^8,2^11);
    gs(i).Trial = chirp_data(i).Trial;
    if plot_bode == 1
       bode(gs(i).function); hold on;
    end
end

clear data;
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
       subplot(column_subplot,1,k); plot(chirp_data(i).timestamp,chirp_data(i).y); hold on; plot(chirp_data(i).timestamp,chirp_data(i).u);
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


clear i j k column_subplot plot_*;