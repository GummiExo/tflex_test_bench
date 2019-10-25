clc; clear all; close all;
addpath('src/');
load('data/selected_trials.mat');
clear chirp_response;

%% Get parameters

step_info = zeros(length(step_response),14);
step_info = array2table(step_info, 'VariableNames', {'td1', 'ts1', 'tr1', 'tp_min', 'initial_value1', 'final_value1', 'td2', 'ts2', 'tr2', 'tp_max', 'initial_value2', 'final_value2', 'max_peak_value', 'min_peak_value'});
for i=1:length(step_response)
    if ~isempty(strfind(step_response(i).Trial,'Stiffness')) == 0
        [step_info.td1(i),step_info.ts1(i),step_info.tr1(i),step_info.tp_min(i),step_info.initial_value1(i),step_info.final_value1(i),step_info.td2(i),step_info.ts2(i),step_info.tr2(i),step_info.tp_max(i),step_info.initial_value2(i),step_info.final_value2(i),step_info.max_peak_value(i),step_info.min_peak_value(i)] = step_parameters_flexion(step_response(i).mean_motor_state_frontal,step_response(i).mean_motor_state_posterior,step_response(i).mean_load); 
    else
        
    end
end
