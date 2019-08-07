clear all; clc; close all;
addpath('./src')
motor_characteristics = ReadYaml('../../yaml/tilt.yaml');

%% Read Trials
%trials_dir = '../tflex_trials/pretension20N/pretension.bag';
%trials_dir = '../tflex_trials/tension20N/step_response1.bag';
%trials_dir = '../tflex_trials/Pretension20N_F_P/step_response.bag';
%trials_dir = '../tflex_trials/Pretension20N_F_P/shirp_signal_response_same_direction.bag';
trials_dir = '../tflex_trials/test_posterior_loadcell.bag';
bag = rosbag(trials_dir);


%% Read Topics
[motor_states_frontal, motor_states_posterior, load_data, frontal_loadcell_data, posterior_loadcell_data, tilt1_command_data, tilt2_command_data] = read_topics(bag);
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
frontal_initial_voltage = 3.88563;
posterior_initial_voltage = 1.8337;
frontal_loadcell_data.Force = ((frontal_loadcell_data.Data - frontal_initial_voltage)/0.0312)*9.8;
posterior_loadcell_data.Force = ((posterior_loadcell_data.Data - posterior_initial_voltage)/0.0246)*9.8;

%Tendon Force
frontal_inclination = deg2rad(83);
frontal_loadcell_data.Tendon_Force = frontal_loadcell_data.Force/sin(frontal_inclination);
posterior_inclination = deg2rad(72);
posterior_loadcell_data.Tendon_Force = posterior_loadcell_data.Force/sin(posterior_inclination);

posterior_filtered = lowpass(posterior_loadcell_data.Data,0.001,length(posterior_loadcell_data.Data)/(bag.EndTime - bag.StartTime));
figure(4)
plot(posterior_loadcell_data.Timestamp,posterior_filtered);

%% Plots
%Goal vs Present Position
figure(1); 
    subplot(1,2,1); plot(motor_states_frontal.Timestamp, motor_states_frontal.Goal_Angle); hold on; plot(motor_states_frontal.Timestamp, motor_states_frontal.Present_Angle);
    subplot(1,2,2); plot(motor_states_posterior.Timestamp, motor_states_posterior.Goal_Angle); hold on; plot(motor_states_posterior.Timestamp, motor_states_posterior.Present_Angle);

%Force Tendon
figure(2)
    plot(frontal_loadcell_data.Tendon_Force); hold on;
    plot(posterior_loadcell_data.Tendon_Force);

%Torque Sensor
figure(3)
    subplot(2,1,1); plot(load_data.Timestamp,load_data.Data);
     subplot(2,1,2); plot(motor_states_frontal.Timestamp,motor_states_frontal.Load_Percentage); hold on;
                     plot(motor_states_posterior.Timestamp,motor_states_posterior.Load_Percentage);
    
