% clc; clear all; close all;
% addpath('src/');
% load('data/selected_trials.mat');
% clear chirp_response;

%% Get parameters of mean signals

% plot_response = "on";
% mean_step_info = zeros(length(step_response),14);
% mean_step_info = array2table(mean_step_info, 'VariableNames', {'td1', 'ts1', 'tr1', 'tp_min', 'initial_value1', 'final_value1', 'td2', 'ts2', 'tr2', 'tp_max', 'initial_value2', 'final_value2', 'max_peak_value', 'min_peak_value'});
% for i=1:length(step_response)
%     if ~isempty(strfind(step_response(i).Trial,'Stiffness')) == 0
%         step_response(i).mean_load.filtered = medfilt1(step_response(i).mean_load.filtered,160)
%         [mean_step_info.td1(i),mean_step_info.ts1(i),mean_step_info.tr1(i),mean_step_info.tp_min(i),mean_step_info.initial_value1(i),mean_step_info.final_value1(i),mean_step_info.td2(i),mean_step_info.ts2(i),mean_step_info.tr2(i),mean_step_info.tp_max(i),mean_step_info.initial_value2(i),mean_step_info.final_value2(i),mean_step_info.max_peak_value(i),mean_step_info.min_peak_value(i)] = step_parameters_flexion(step_response(i).mean_motor_state_frontal,step_response(i).mean_motor_state_posterior,step_response(i).mean_load,plot_response); 
%     else
%         %TO DO Stiffness Movement
%     end
% end

%% Read all trials
clear all; close all; clc;
cd data/step_response/
files = dir('*.mat');

%% Step Parameters
plot_response = "off";
for i=1:length(files)
   load(files(i).name);
   for j=1:size(matrix_load.Data,1)
        input1.Timestamp = matrix_frontal_motor.Timestamp(j,:);
        input1.goal_angle = matrix_frontal_motor.goal_angle(j,:);
        input2.Timestamp = matrix_posterior_motor.Timestamp(j,:);
        input2.goal_angle = matrix_posterior_motor.goal_angle(j,:);
        output.Timestamp = matrix_load.Timestamp(j,:);
        output.filtered = medfilt1(matrix_load.filtered(j,:),50);
        
        %Pre-Processing
        if i == 3 && j == 10
          output.filtered(719:803) = (output.filtered(718) + output.filtered(802))/2;
          %plot(output.filtered); title('Signal Adjusted')
        elseif i == 3 && j == 11
          output.filtered(641:693) = (output.filtered(640) + output.filtered(694))/2;
          output.filtered(701:730) = (output.filtered(700) + output.filtered(731))/2;
          %plot(output.filtered); title('Signal Adjusted')
        elseif i == 8
            output.filtered = medfilt1(output.filtered,90);
            plot(output.filtered); title('Signal Adjusted')
        end
        
        if ~isempty(strfind(files(i).name,'Stiffness')) == 0
            output.filtered = medfilt1(output.filtered,10);
            %plot(output.filtered)
            [step_info{i}.td1(j),step_info{i}.ts1(j),step_info{i}.tr1(j),step_info{i}.tp_min(j),step_info{i}.initial_value1(j),step_info{i}.final_value1(j),step_info{i}.td2(j),step_info{i}.ts2(j),step_info{i}.tr2(j),step_info{i}.tp_max(j),step_info{i}.initial_value2(j),step_info{i}.final_value2(j),step_info{i}.max_peak_value(j),step_info{i}.min_peak_value(j)] = step_parameters_flexion(input1,input2,output,plot_response); 
            step_info{i}.Trial = files(i).name;
        else
            output.filtered = medfilt1(output.filtered,30);
            %plot(output.Timestamp,output.filtered)
            [step_info{i}.td1(j),step_info{i}.ts1(j),step_info{i}.tr1(j),step_info{i}.tp_min(j),step_info{i}.initial_value1(j),step_info{i}.final_value1(j),step_info{i}.td2(j),step_info{i}.ts2(j),step_info{i}.tr2(j),step_info{i}.tp_max(j),step_info{i}.initial_value2(j),step_info{i}.final_value2(j),step_info{i}.max_peak_value(j),step_info{i}.min_peak_value(j)] = step_parameters_stiffness(input1,input2,output,plot_response); 
            step_info{i}.Trial = files(i).name;
        end
        clear input* output
    end
end

step_info = (cat(1,step_info{1,:}));

%% Post-Processing
%Flexo-Extension
step_info(1).td1(17) = mean(step_info(1).td1(1:18));
step_info(1).ts2(9) = mean(step_info(1).ts2(1:8));
step_info(1).ts2(10) = mean(step_info(1).ts2(1:9));
step_info(1).ts2(11) = mean(step_info(1).ts2(1:10));
step_info(1).ts2(12) = mean(step_info(1).ts2(1:11));
step_info(1).ts2(13) = mean(step_info(1).ts2(1:12));
step_info(1).ts2(14) = mean(step_info(1).ts2(1:13));
step_info(1).ts2(16) = mean(step_info(1).ts2(1:15));
step_info(1).ts2(17) = mean(step_info(1).ts2(1:16));

step_info(2).ts2(18) = mean(step_info(2).ts2(1:17));

step_info(3).td1(17) = mean(step_info(3).td1(1:16));
step_info(3).ts1(3) = mean(step_info(3).ts1(1:2));
step_info(3).ts1(4) = mean(step_info(3).ts1(1:3));
step_info(3).ts1(5) = mean(step_info(3).ts1(1:4));
step_info(3).ts1(8) = mean(step_info(3).ts1(1:7));
step_info(3).ts1(10) = mean(step_info(3).ts1(1:9));
step_info(3).ts1(11) = mean(step_info(3).ts1(1:10));
step_info(3).ts1(12) = mean(step_info(3).ts1(1:11));
step_info(3).ts1(13) = mean(step_info(3).ts1(1:12));
step_info(3).ts1(14) = mean(step_info(3).ts1(1:13));
step_info(3).ts1(15) = mean(step_info(3).ts1(1:14));

step_info(4).td2(11) = mean(step_info(4).td2(1:10));
step_info(4).td2(12) = mean(step_info(4).td2(1:11));
step_info(4).td2(13) = mean(step_info(4).td2(1:12));

%Stiffness
step_info(7).td1(1) = mean(step_info(7).td1(2:9));
step_info(7).td1(10) = mean(step_info(7).td1(1:9));
step_info(7).td1(11) = mean(step_info(7).td1(1:11));
step_info(7).td1(16) = mean(step_info(7).td1(1:15));
step_info(7).td1(18) = mean(step_info(7).td1(1:17));
step_info(7).ts2(5) = mean(step_info(7).ts2(1:4));
step_info(7).ts2(7) = mean(step_info(7).ts2(1:6));
step_info(7).ts2(11) = mean(step_info(7).ts2(1:10));
step_info(7).ts2(18) = mean(step_info(7).ts2(1:17));

step_info(8).td1(6) = mean(step_info(8).td1(1:5));
step_info(8).td1(8) = mean(step_info(8).td1(1:7));
step_info(8).td1(10) = mean(step_info(8).td1(1:9));
step_info(8).td1(12) = mean(step_info(8).td1(1:11));
step_info(8).tr1(10) = mean(step_info(8).tr1(1:9));
step_info(8).tr1(12) = mean(step_info(8).tr1(1:11));
step_info(8).tr1(17) = mean(step_info(8).tr1(1:16));
step_info(8).tr1(18) = mean(step_info(8).tr1(1:17));
step_info(8).tr1(19) = mean(step_info(8).tr1(1:18));


step_info(9).td1(9) = mean(step_info(9).td1(1:8));
step_info(9).ts1(3) = mean(step_info(9).ts1(1:2));
step_info(9).ts1(8) = mean(step_info(9).ts1(1:7));
step_info(9).ts1(10) = mean(step_info(9).ts1(1:9));
step_info(9).ts1(11) = mean(step_info(9).ts1(1:10));
step_info(9).ts1(15) = mean(step_info(9).ts1(1:14));
step_info(9).ts1(16) = mean(step_info(9).ts1(1:15));
step_info(9).ts1(17) = mean(step_info(9).ts1(1:16));
step_info(9).ts1(18) = mean(step_info(9).ts1(1:17));
step_info(9).ts1(19) = mean(step_info(9).ts1(1:18));
step_info(9).ts2(2) = mean(step_info(9).ts2(3:14));
step_info(9).ts2(18) = mean(step_info(9).ts2(1:17));

%% Mean Value and Standar Deviation
num_trials = 1;

for i = num_trials:num_trials:length(step_info)
    td1 = []; ts1 = []; tr1 = []; td2 = []; ts2 = []; tr2 = []; initial_value1 = []; final_value1 = []; initial_value2 = []; final_value2 = []; max_peak_value = []; min_peak_value = [];
    if num_trials == 1
        td1 = step_info(i).td1;
        ts1 = step_info(i).ts1;
        tr1 = step_info(i).tr1;
        td2 = step_info(i).td2;
        ts2 = step_info(i).ts2;
        tr2 = step_info(i).tr2;
        initial_value1 = step_info(i).initial_value1;
        final_value1 = step_info(i).final_value1;
        initial_value2 = step_info(i).initial_value2;
        final_value2 = step_info(i).final_value2 ;
        max_peak_value = step_info(i).max_peak_value;
        min_peak_value = step_info(i).min_peak_value;
    elseif num_trials == 3
        td1 = [step_info(i-2).td1 step_info(i-1).td1 step_info(i).td1];
        ts1 = [step_info(i-2).ts1 step_info(i-1).ts1 step_info(i).ts1];
        tr1 = [step_info(i-2).tr1 step_info(i-1).tr1 step_info(i).tr1];
        td2 = [step_info(i-2).td2 step_info(i-1).td2 step_info(i).td2];
        ts2 = [step_info(i-2).ts2 step_info(i-1).ts2 step_info(i).ts2];
        tr2 = [step_info(i-2).tr2 step_info(i-1).tr2 step_info(i).tr2];
        initial_value1 = [step_info(i-2).initial_value1 step_info(i-1).initial_value1 step_info(i).initial_value1];
        final_value1 = [step_info(i-2).final_value1 step_info(i-1).final_value1 step_info(i).final_value1];
        initial_value2 = [step_info(i-2).initial_value2 step_info(i-1).initial_value2 step_info(i).initial_value2];
        final_value2 = [step_info(i-2).final_value2 step_info(i-1).final_value2 step_info(i).final_value2];
        max_peak_value = [step_info(i-2).max_peak_value step_info(i-1).max_peak_value step_info(i).max_peak_value];
        min_peak_value = [step_info(i-2).min_peak_value step_info(i-1).min_peak_value step_info(i).min_peak_value];
    end
    
    mean_std_trials(i/num_trials).time_delay.mean1 = mean(td1);
    mean_std_trials(i/num_trials).time_delay.std1 = std(td1);
    mean_std_trials(i/num_trials).time_stabilization.mean1 = mean(ts1);
    mean_std_trials(i/num_trials).time_stabilization.std1 = std(ts1);
    mean_std_trials(i/num_trials).time_rise.mean1 = mean(tr1);
    mean_std_trials(i/num_trials).time_rise.std1 = std(tr1);
    mean_std_trials(i/num_trials).initial_value.mean1 = mean(initial_value1);
    mean_std_trials(i/num_trials).initial_value.std1 = std(initial_value1);
    mean_std_trials(i/num_trials).final_value.mean1 = mean(final_value1);
    mean_std_trials(i/num_trials).final_value.std1 = std(final_value1);
    mean_std_trials(i/num_trials).peak_values.mean_max = mean(max_peak_value);
    mean_std_trials(i/num_trials).peak_values.std_max = std(max_peak_value);
    mean_std_trials(i/num_trials).peak_values.mean_min = mean(min_peak_value);
    mean_std_trials(i/num_trials).peak_values.std_min = std(min_peak_value);
    mean_std_trials(i/num_trials).time_delay.mean2 = mean(td2);
    mean_std_trials(i/num_trials).time_delay.std2 = std(td2);
    mean_std_trials(i/num_trials).time_stabilization.mean2 = mean(ts2);
    mean_std_trials(i/num_trials).time_stabilization.std2 = std(ts2);
    mean_std_trials(i/num_trials).time_rise.mean2 = mean(tr2);
    mean_std_trials(i/num_trials).time_rise.std2 = std(tr2);
    mean_std_trials(i/num_trials).initial_value.mean2 = mean(initial_value2);
    mean_std_trials(i/num_trials).initial_value.std2 = std(initial_value2);
    mean_std_trials(i/num_trials).final_value.mean2 = mean(initial_value2);
    mean_std_trials(i/num_trials).final_value.std2 = std(initial_value2);
    mean_std_trials(i/num_trials).Trial = step_info(i - (num_trials -1)).Trial(1:end-4);
    
end

%% Shapiro-Wilk Test Flexion-Stiffness

for i = num_trials:num_trials:length(step_info)
    [swtest_values(i/num_trials).time_delay.H1 swtest_values(i/num_trials).time_delay.p_value1 swtest_values(i/num_trials).time_delay.SWsta1] = swtest(step_info(i).td1);
    [swtest_values(i/num_trials).time_stabilization.H1 swtest_values(i/num_trials).time_stabilization.p_value swtest_values(i/num_trials).time_stabilization.SWsta1] = swtest(step_info(i).ts1);
    [swtest_values(i/num_trials).time_rise.H1 swtest_values(i/num_trials).time_rise.p_value1 swtest_values(i/num_trials).time_rise.SWsta1] = swtest(step_info(i).tr1);
    [swtest_values(i/num_trials).time_delay.H2 swtest_values(i/num_trials).time_delay.p_value2 swtest_values(i/num_trials).time_delay.SWsta2] = swtest(step_info(i).td2);
    [swtest_values(i/num_trials).time_stabilization.H2 swtest_values(i/num_trials).time_stabilization.p_value2 swtest_values(i/num_trials).time_stabilization.SWsta2] = swtest(step_info(i).ts2);
    [swtest_values(i/num_trials).time_rise.H2 swtest_values(i/num_trials).time_rise.p_value2 swtest_values(i/num_trials).time_rise.SWsta2] = swtest(step_info(i).td2);
     swtest_values(i/num_trials).Trial =  step_info(i - (num_trials -1)).Trial(1:end-4);
    
end

%% Plot Step Parameters Flexo-Extension
    delay_mean1 = [mean_std_trials(3).time_delay.mean1*1000; mean_std_trials(1).time_delay.mean1*1000; mean_std_trials(2).time_delay.mean1*1000; mean_std_trials(6).time_delay.mean1*1000; mean_std_trials(4).time_delay.mean1*1000; mean_std_trials(5).time_delay.mean1*1000];
    delay_std1 = [mean_std_trials(3).time_delay.std1*1000; mean_std_trials(1).time_delay.std1*1000; mean_std_trials(2).time_delay.std1*1000; mean_std_trials(6).time_delay.std1*1000; mean_std_trials(4).time_delay.std1*1000; mean_std_trials(5).time_delay.std1*1000];
    sta_mean1 = [mean_std_trials(3).time_stabilization.mean1*1000; mean_std_trials(1).time_stabilization.mean1*1000; mean_std_trials(2).time_stabilization.mean1*1000; mean_std_trials(6).time_stabilization.mean1*1000; mean_std_trials(4).time_stabilization.mean1*1000; mean_std_trials(5).time_stabilization.mean1*1000];
    sta_std1 = [mean_std_trials(3).time_stabilization.std1*1000; mean_std_trials(1).time_stabilization.std1*1000; mean_std_trials(2).time_stabilization.std1*1000; mean_std_trials(6).time_stabilization.std1*1000; mean_std_trials(4).time_stabilization.std1*1000; mean_std_trials(5).time_stabilization.std1*1000];
    rise_mean1 = [mean_std_trials(3).time_rise.mean1*1000; mean_std_trials(1).time_rise.mean1*1000; mean_std_trials(2).time_rise.mean1*1000; mean_std_trials(6).time_rise.mean1*1000; mean_std_trials(4).time_rise.mean1*1000; mean_std_trials(5).time_rise.mean1*1000];
    rise_std1 = [mean_std_trials(3).time_rise.std1*1000; mean_std_trials(1).time_rise.std1*1000; mean_std_trials(2).time_rise.std1*1000; mean_std_trials(6).time_rise.std1*1000; mean_std_trials(4).time_rise.std1*1000; mean_std_trials(5).time_rise.std1*1000];

    delay_mean2 = [mean_std_trials(3).time_delay.mean2*1000; mean_std_trials(1).time_delay.mean2*1000; mean_std_trials(2).time_delay.mean2*1000; mean_std_trials(6).time_delay.mean2*1000; mean_std_trials(4).time_delay.mean2*1000; mean_std_trials(5).time_delay.mean2*1000];
    delay_std2 = [mean_std_trials(3).time_delay.std2*1000; mean_std_trials(1).time_delay.std2*1000; mean_std_trials(2).time_delay.std2*1000; mean_std_trials(6).time_delay.std2*1000; mean_std_trials(4).time_delay.std2*1000; mean_std_trials(5).time_delay.std2*1000];
    sta_mean2 = [mean_std_trials(3).time_stabilization.mean2*1000; mean_std_trials(1).time_stabilization.mean2*1000; mean_std_trials(2).time_stabilization.mean2*1000; mean_std_trials(6).time_stabilization.mean2*1000; mean_std_trials(4).time_stabilization.mean2*1000; mean_std_trials(5).time_stabilization.mean2*1000];
    sta_std2 = [mean_std_trials(3).time_stabilization.std2*1000; mean_std_trials(1).time_stabilization.std2*1000; mean_std_trials(2).time_stabilization.std2*1000; mean_std_trials(6).time_stabilization.std2*1000; mean_std_trials(4).time_stabilization.std2*1000; mean_std_trials(5).time_stabilization.std2*1000];
    rise_mean2 = [mean_std_trials(3).time_rise.mean2*1000; mean_std_trials(1).time_rise.mean2*1000; mean_std_trials(2).time_rise.mean2*1000; mean_std_trials(6).time_rise.mean2*1000; mean_std_trials(4).time_rise.mean2*1000; mean_std_trials(5).time_rise.mean2*1000];
    rise_std2 = [mean_std_trials(3).time_rise.std2*1000; mean_std_trials(1).time_rise.std2*1000; mean_std_trials(2).time_rise.std2*1000; mean_std_trials(6).time_rise.std2*1000; mean_std_trials(4).time_rise.std2*1000; mean_std_trials(5).time_rise.std2*1000];
figure;
    
    subplot(2,3,1); bar(delay_mean1);  hold on; errorbar(1:6,delay_mean1,delay_std1,'LineStyle','none')
    set(gca, 'XTickLabel',{'RT:5N','RT:10N','RT:20N','T:5N','T:10N','T:20N'});
    title('Delay Time Flexion'); ylabel('Time [ms]'); hold off; 
    
    subplot(2,3,2); bar(sta_mean1);  hold on; errorbar(1:6,sta_mean1,sta_std1,'LineStyle','none');
    set(gca, 'XTickLabel',{'RT:5N','RT:10N','RT:20N','T:5N','T:10N','T:20N'});
    title('Stabilization Time Flexion'); ylabel('Time [ms]'); hold off; 
    
    subplot(2,3,3); bar(rise_mean1);  hold on; errorbar(1:6,rise_mean1,rise_std1,'LineStyle','none');
    set(gca, 'XTickLabel',{'RT:5N','RT:10N','RT:20N','T:5N','T:10N','T:20N'});
    title('Rise Time Flexion'); ylabel('Time [ms]'); hold off; 
    
    subplot(2,3,4); bar(delay_mean2);  hold on; errorbar(1:6,delay_mean2,delay_std2,'LineStyle','none')
    set(gca, 'XTickLabel',{'RT:5N','RT:10N','RT:20N','T:5N','T:10N','T:20N'});
    title('Delay Time Extension'); ylabel('Time [ms]'); hold off; 
    
    subplot(2,3,5); bar(sta_mean2);  hold on; errorbar(1:6,sta_mean2,sta_std2,'LineStyle','none');
    set(gca, 'XTickLabel',{'RT:5N','RT:10N','RT:20N','T:5N','T:10N','T:20N'});
    title('Stabilization Time Extension'); ylabel('Time [ms]'); hold off; 
    
    subplot(2,3,6); bar(rise_mean2);  hold on; errorbar(1:6,rise_mean2,rise_std2,'LineStyle','none');
    set(gca, 'XTickLabel',{'RT:5N','RT:10N','RT:20N','T:5N','T:10N','T:20N'});
    title('Rise Time Extension'); ylabel('Time [ms]'); hold off; 
    
    suptitle('Time Values for Flexo-Extension')
    
%% Plot Step Parameters Stiffness
    clear delay* sta* rise*
    delay_mean1 = [mean_std_trials(9).time_delay.mean1*1000; mean_std_trials(7).time_delay.mean1*1000; mean_std_trials(8).time_delay.mean1*1000];
    delay_std1 = [mean_std_trials(9).time_delay.std1*1000; mean_std_trials(7).time_delay.std1*1000; mean_std_trials(8).time_delay.std1*1000];
    sta_mean1 = [mean_std_trials(9).time_stabilization.mean1*1000; mean_std_trials(7).time_stabilization.mean1*1000; mean_std_trials(8).time_stabilization.mean1*1000];
    sta_std1 = [mean_std_trials(9).time_stabilization.std1*1000; mean_std_trials(7).time_stabilization.std1*1000; mean_std_trials(8).time_stabilization.std1*1000];
    rise_mean1 = [mean_std_trials(9).time_rise.mean1*1000; mean_std_trials(7).time_rise.mean1*1000; mean_std_trials(8).time_rise.mean1*1000];
    rise_std1 = [mean_std_trials(9).time_rise.std1*1000; mean_std_trials(7).time_rise.std1*1000; mean_std_trials(8).time_rise.std1*1000];

    delay_mean2 = [mean_std_trials(9).time_delay.mean2*1000; mean_std_trials(7).time_delay.mean2*1000; mean_std_trials(8).time_delay.mean2*1000];
    delay_std2 = [mean_std_trials(9).time_delay.std2*1000; mean_std_trials(7).time_delay.std2*1000; mean_std_trials(8).time_delay.std2*1000];
    sta_mean2 = [mean_std_trials(9).time_stabilization.mean2*1000; mean_std_trials(7).time_stabilization.mean2*1000; mean_std_trials(8).time_stabilization.mean2*1000];
    sta_std2 = [mean_std_trials(9).time_stabilization.std2*1000; mean_std_trials(7).time_stabilization.std2*1000; mean_std_trials(8).time_stabilization.std2*1000];
    rise_mean2 = [mean_std_trials(9).time_rise.mean2*1000; mean_std_trials(7).time_rise.mean2*1000; mean_std_trials(8).time_rise.mean2*1000];
    rise_std2 = [mean_std_trials(9).time_rise.std2*1000; mean_std_trials(7).time_rise.std2*1000; mean_std_trials(8).time_rise.std2*1000];
figure;
    
    subplot(2,3,1); bar(delay_mean1);  hold on; errorbar(1:3,delay_mean1,delay_std1,'LineStyle','none')
    set(gca, 'XTickLabel',{'T:5N','T:10N','T:20N'});
    title('Delay Stiffness'); ylabel('Time [ms]'); hold off; 
    
    subplot(2,3,2); bar(sta_mean1);  hold on; errorbar(1:3,sta_mean1,sta_std1,'LineStyle','none');
    set(gca, 'XTickLabel',{'T:5N','T:10N','T:20N'});
    title('Stabilization Time Stiffness'); ylabel('Time [ms]'); hold off; 
    
    subplot(2,3,3); bar(rise_mean1);  hold on; errorbar(1:3,rise_mean1,rise_std1,'LineStyle','none');
    set(gca, 'XTickLabel',{'T:5N','T:10N','T:20N'});
    title('Rise Time Stiffness'); ylabel('Time [ms]'); hold off; 
    
    subplot(2,3,4); bar(delay_mean2);  hold on; errorbar(1:3,delay_mean2,delay_std2,'LineStyle','none')
    set(gca, 'XTickLabel',{'T:5N','T:10N','T:20N'});
    title('Delay Time Zero Position'); ylabel('Time [ms]'); hold off; 
    
    subplot(2,3,5); bar(sta_mean2);  hold on; errorbar(1:3,sta_mean2,sta_std2,'LineStyle','none');
    set(gca, 'XTickLabel',{'T:5N','T:10N','T:20N'});
    title('Stabilization Time Zero Position'); ylabel('Time [ms]'); hold off; 
    
    subplot(2,3,6); bar(rise_mean2);  hold on; errorbar(1:3,rise_mean2,rise_std2,'LineStyle','none');
    set(gca, 'XTickLabel',{'T:5N','T:10N','T:20N'});
    title('Rise Time Zero Position'); ylabel('Time [ms]'); hold off; 
    
    suptitle('Time Values for Stiffness')

%% Clean Workspace

clearvars -except step_info swtest_values mean_std_trials step_info

