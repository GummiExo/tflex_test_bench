clc; clear all; close all;
addpath('src/');
load('data/selected_trials.mat');
clear chirp_response;

%% Get parameters of mean signals

plot_response = "off";
mean_step_info = zeros(length(step_response),14);
mean_step_info = array2table(mean_step_info, 'VariableNames', {'td1', 'ts1', 'tr1', 'tp_min', 'initial_value1', 'final_value1', 'td2', 'ts2', 'tr2', 'tp_max', 'initial_value2', 'final_value2', 'max_peak_value', 'min_peak_value'});
for i=1:length(step_response)
    if ~isempty(strfind(step_response(i).Trial,'Stiffness')) == 0
        [mean_step_info.td1(i),mean_step_info.ts1(i),mean_step_info.tr1(i),mean_step_info.tp_min(i),mean_step_info.initial_value1(i),mean_step_info.final_value1(i),mean_step_info.td2(i),mean_step_info.ts2(i),mean_step_info.tr2(i),mean_step_info.tp_max(i),mean_step_info.initial_value2(i),mean_step_info.final_value2(i),mean_step_info.max_peak_value(i),mean_step_info.min_peak_value(i)] = step_parameters_flexion(step_response(i).mean_motor_state_frontal,step_response(i).mean_motor_state_posterior,step_response(i).mean_load,plot_response); 
    else
        %TO DO Stiffness Movement
    end
end

%% Read all trials
clear all; close all; clc;
cd data/step_response/
files = dir('*.mat');
plot_response = "off";

for i=1:length(files)
   load(files(i).name);
   if ~isempty(strfind(files(i).name,'Stiffness')) == 0
       for j=1:size(matrix_load.Data,1)
           input1.Timestamp = matrix_frontal_motor.Timestamp(j,:);
           input1.goal_angle = matrix_frontal_motor.goal_angle(j,:);
           input2.Timestamp = matrix_posterior_motor.Timestamp(j,:);
           input2.goal_angle = matrix_posterior_motor.goal_angle(j,:);
           output.Timestamp = matrix_load.Timestamp(j,:);
           output.filtered = medfilt1(matrix_load.filtered(j,:),40);
           [step_info{i}.td1(j),step_info{i}.ts1(j),step_info{i}.tr1(j),step_info{i}.tp_min(j),step_info{i}.initial_value1(j),step_info{i}.final_value1(j),step_info{i}.td2(j),step_info{i}.ts2(j),step_info{i}.tr2(j),step_info{i}.tp_max(j),step_info{i}.initial_value2(j),step_info{i}.final_value2(j),step_info{i}.max_peak_value(j),step_info{i}.min_peak_value(j)] = step_parameters_flexion(input1,input2,output,plot_response); 
       end
       step_info{i}.Trial = files(i).name;
       close all;
   else
       %TO DO Stiffness Movement
    end
end

%% Mean Value and Standar Deviation

for i = 3:3:length(step_info)
    td1 = []; ts1 = []; tr1 = []; td2 = []; ts2 = []; tr2 = []; initial_value1 = []; final_value1 = []; initial_value2 = []; final_value2 = []; max_peak_value = []; min_peak_value = [];
    td1 = [step_info{i-2}.td1 step_info{i-1}.td1 step_info{i}.td1];
    ts1 = [step_info{i-2}.ts1 step_info{i-1}.ts1 step_info{i}.ts1];
    tr1 = [step_info{i-2}.tr1 step_info{i-1}.tr1 step_info{i}.tr1];
    td2 = [step_info{i-2}.td2 step_info{i-1}.td2 step_info{i}.td2];
    ts2 = [step_info{i-2}.ts2 step_info{i-1}.ts2 step_info{i}.ts2];
    tr2 = [step_info{i-2}.tr2 step_info{i-1}.tr2 step_info{i}.tr2];
    initial_value1 = [step_info{i-2}.initial_value1 step_info{i-1}.initial_value1 step_info{i}.initial_value1];
    final_value1 = [step_info{i-2}.final_value1 step_info{i-1}.final_value1 step_info{i}.final_value1];
    initial_value2 = [step_info{i-2}.initial_value2 step_info{i-1}.initial_value2 step_info{i}.initial_value2];
    final_value2 = [step_info{i-2}.final_value2 step_info{i-1}.final_value2 step_info{i}.final_value2];
    max_peak_value = [step_info{i-2}.max_peak_value step_info{i-1}.max_peak_value step_info{i}.max_peak_value];
    min_peak_value = [step_info{i-2}.min_peak_value step_info{i-1}.min_peak_value step_info{i}.min_peak_value];
    
    
    mean_std_trials(i/3).time_delay.mean1 = mean(td1);
    mean_std_trials(i/3).time_delay.std1 = std(td1);
    mean_std_trials(i/3).time_stabilization.mean1 = mean(ts1);
    mean_std_trials(i/3).time_stabilization.std1 = std(ts1);
    mean_std_trials(i/3).time_rise.mean1 = mean(tr1);
    mean_std_trials(i/3).time_rise.std1 = std(tr1);
    mean_std_trials(i/3).initial_value.mean1 = mean(initial_value1);
    mean_std_trials(i/3).initial_value.std1 = std(initial_value1);
    mean_std_trials(i/3).final_value.mean1 = mean(final_value1);
    mean_std_trials(i/3).final_value.std1 = std(final_value1);
    mean_std_trials(i/3).peak_values.mean_max = mean(max_peak_value);
    mean_std_trials(i/3).peak_values.std_max = std(max_peak_value);
    mean_std_trials(i/3).peak_values.mean_min = mean(min_peak_value);
    mean_std_trials(i/3).peak_values.std_min = std(min_peak_value);
    mean_std_trials(i/3).time_delay.mean2 = mean(td2);
    mean_std_trials(i/3).time_delay.std2 = std(td2);
    mean_std_trials(i/3).time_stabilization.mean2 = mean(ts2);
    mean_std_trials(i/3).time_stabilization.std2 = std(ts2);
    mean_std_trials(i/3).time_rise.mean2 = mean(tr2);
    mean_std_trials(i/3).time_rise.std2 = std(tr2);
    mean_std_trials(i/3).initial_value.mean2 = mean(initial_value2);
    mean_std_trials(i/3).initial_value.std2 = std(initial_value2);
    mean_std_trials(i/3).final_value.mean2 = mean(initial_value2);
    mean_std_trials(i/3).final_value.std2 = std(initial_value2);
    mean_std_trials(i/3).Trial = step_info{i-2}.Trial(1:end-4);
    
end

%% Shapiro-Wilk Test

for i = 3:3:length(step_info)
    td1 = []; ts1 = []; tr1 = []; td2 = []; ts2 = []; tr2 = [];
    td1 = [step_info{i-2}.td1 step_info{i-1}.td1 step_info{i}.td1];
    ts1 = [step_info{i-2}.ts1 step_info{i-1}.ts1 step_info{i}.ts1];
    tr1 = [step_info{i-2}.tr1 step_info{i-1}.tr1 step_info{i}.tr1];
    td2 = [step_info{i-2}.td2 step_info{i-1}.td2 step_info{i}.td2];
    ts2 = [step_info{i-2}.ts2 step_info{i-1}.ts2 step_info{i}.ts2];
    tr2 = [step_info{i-2}.tr2 step_info{i-1}.tr2 step_info{i}.tr2];
    
    [swtest_values(i/3).time_delay.H1 swtest_values(i/3).time_delay.p_value1 swtest_values(i/3).time_delay.SWsta1] = swtest(td1);
    [swtest_values(i/3).time_stabilization.H1 swtest_values(i/3).time_stabilization.p_value swtest_values(i/3).time_stabilization.SWsta1] = swtest(ts1);
    [swtest_values(i/3).time_rise.H1 swtest_values(i/3).time_rise.p_value1 swtest_values(i/3).time_rise.SWsta1] = swtest(tr1);
    [swtest_values(i/3).time_delay.H2 swtest_values(i/3).time_delay.p_value2 swtest_values(i/3).time_delay.SWsta2] = swtest(td2);
    [swtest_values(i/3).time_stabilization.H2 swtest_values(i/3).time_stabilization.p_value2 swtest_values(i/3).time_stabilization.SWsta2] = swtest(ts2);
    [swtest_values(i/3).time_rise.H2 swtest_values(i/3).time_rise.p_value2 swtest_values(i/3).time_rise.SWsta2] = swtest(td2);
    swtest_values(i/3).Trial = step_info{i-2}.Trial(1:end-4);
    
end


