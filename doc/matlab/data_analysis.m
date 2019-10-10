clear all; clc; close all;
addpath('./src')
motor_characteristics = ReadYaml('../../yaml/tilt.yaml');

%% Read Trials
%trials_dir = '../tflex_trials/initial_state.bag';
%trials_dir = '../tflex_trials/equal_pretension/80N/chirp_response_opposite_direction.bag';
%trials_dir = '../tflex_trials/equal_pretension/80N/chirp_response_same_direction.bag';
%trials_dir = '/home/tflex-pc/Documents/Bags T-FLEX/V3.0/therapy.bag'

trials_dir = '../tflex_trials/step_response3.bag';
bag = rosbag(trials_dir);


%% Read Topics
[motor_states_frontal, motor_states_posterior, load_data, frontal_loadcell_data, posterior_loadcell_data, frontal_loadcell_force, posterior_loadcell_force, tilt1_command_data, tilt2_command_data] = read_topics(bag);
%[load_data, frontal_loadcell_data, posterior_loadcell_data, tilt1_command_data, tilt2_command_data] = read_topics(bag);

%Normalized Timestamp
motor_states_frontal.Timestamp = motor_states_frontal.Timestamp - bag.StartTime;
motor_states_posterior.Timestamp = motor_states_posterior.Timestamp - bag.StartTime;
load_data.Timestamp = load_data.Timestamp - bag.StartTime;
frontal_loadcell_data.Timestamp = frontal_loadcell_data.Timestamp - bag.StartTime;
posterior_loadcell_data.Timestamp = posterior_loadcell_data.Timestamp - bag.StartTime;
tilt1_command_data.Timestamp = tilt1_command_data.Timestamp - bag.StartTime;
tilt2_command_data.Timestamp = tilt2_command_data.Timestamp - bag.StartTime;


%% Motor Characteristics

%Position to Degrees
motor_states_frontal.Present_Angle = (double(motor_states_frontal.Position) - double(motor_characteristics.tilt1_controller.motor.init))*360.0/4095.0;
motor_states_frontal.Goal_Angle = (double(motor_states_frontal.Goal) - double(motor_characteristics.tilt1_controller.motor.init))*360.0/4095.0;
motor_states_posterior.Present_Angle = (double(motor_characteristics.tilt2_controller.motor.init) - double(motor_states_posterior.Position))*360.0/4095.0;
motor_states_posterior.Goal_Angle = (double(motor_characteristics.tilt2_controller.motor.init) - double(motor_states_posterior.Goal))*360.0/4095.0;

%Load to percentage
motor_states_frontal.Load_Percentage = motor_states_frontal.Load*100;
motor_states_posterior.Load_Percentage = motor_states_posterior.Load*100;

%tilt_command to degrees
tilt1_command_data.Angle = tilt1_command_data.Data*180/pi;
tilt2_command_data.Angle = tilt2_command_data.Data*180/pi;

%% Loadcell Characteristics

% %Filters
% len_frontal = length(frontal_loadcell_data.Data);
% len_posterior = length(posterior_loadcell_data.Data);
% frontal_loadcell_data.filtered = lowpass(frontal_loadcell_data.Data,0.001,len_frontal/(frontal_loadcell_data.Timestamp(len_frontal) - frontal_loadcell_data.Timestamp(1)));
% posterior_loadcell_data.filtered = lowpass(posterior_loadcell_data.Data,0.001,len_posterior/(posterior_loadcell_data.Timestamp(len_posterior) - posterior_loadcell_data.Timestamp(1)));
% figure(4)
% plot(frontal_loadcell_data.Timestamp, frontal_loadcell_data.filtered); hold on; plot(posterior_loadcell_data.Timestamp,posterior_loadcell_data.filtered); legend('Frontal','Posterior'); title('Loadcell Data Filtered');
% 
% frontal_initial_voltage = 3.421;
% factor_frontal = 0.0003329729;
% posterior_initial_voltage = 1.802;
% factor_posterior = 0.0006506158;
% frontal_loadcell_data.Force = ((frontal_loadcell_data.filtered - frontal_initial_voltage)/factor_frontal);
% posterior_loadcell_data.Force = ((posterior_loadcell_data.filtered - posterior_initial_voltage)/factor_posterior);
% 
% %Tendon Force
% frontal_inclination = deg2rad(97);
% frontal_loadcell_data.Tendon_Force = frontal_loadcell_data.Force/sin(frontal_inclination);
% posterior_inclination = deg2rad(82);
% posterior_loadcell_data.Tendon_Force = posterior_loadcell_data.Force/sin(posterior_inclination);

%figure(4)
%plot(frontal_loadcell_force.Timestamp, frontal_loadcell_force.Data); hold on; plot(posterior_loadcell_force.Timestamp,posterior_loadcell_force.Data); legend('Frontal','Posterior'); title('Loadcell Force');


%% Data processing

load_data.filtered = medfilt1(load_data.Data);


%% Plots
%Goal vs Present Position
figure(1); 
    subplot(1,2,1); plot(motor_states_frontal.Timestamp, motor_states_frontal.Goal_Angle); hold on; plot(motor_states_frontal.Timestamp, motor_states_frontal.Present_Angle);
    subplot(1,2,2); plot(motor_states_posterior.Timestamp, motor_states_posterior.Goal_Angle); hold on; plot(motor_states_posterior.Timestamp, motor_states_posterior.Present_Angle);

%Force Tendon
figure(2)
    plot(frontal_loadcell_force.Timestamp,frontal_loadcell_force.Data); hold on;
    plot(posterior_loadcell_force.Timestamp,posterior_loadcell_force.Data);
    legend('Frontal','Posterior');

%Torque Sensor
figure(3)
    subplot(2,1,1); plot(load_data.Timestamp,load_data.filtered);
    subplot(2,1,2); plot(motor_states_frontal.Timestamp,motor_states_frontal.Load_Percentage); hold on;
                    plot(motor_states_posterior.Timestamp,motor_states_posterior.Load_Percentage);
                    legend('Frontal','Posterior')
    
