clear all; clc; close all;
%Read Trials
trials_dir = '../tflex_trials/test.bag';
bag_test = rosbag(trials_dir);

%% Topics

%Dynamixel Motors
frontal_dynamixel_status_topic = select(bag_test,'Topic','/motor_states/frontal_tilt_port');
frontal_dynamixel_status_msgs = readMessages(frontal_dynamixel_status_topic,'DataFormat','struct');
posterior_dynamixel_status_topic = select(bag_test,'Topic','/motor_states/posterior_tilt_port');
posterior_dynamixel_status_msgs = readMessages(posterior_dynamixel_status_topic,'DataFormat','struct');
cat_data = cat(1,frontal_dynamixel_status_msgs{:,1});
motor_states_frontal = cat(1,cat_data(:).MotorStates);
clear cat_data;
cat_data = cat(1,posterior_dynamixel_status_msgs{:,1});
motor_states_posterior = cat(1,cat_data(:).MotorStates);
clear cat_data;

%Torque Sensor
load_data_topic = select(bag_test,'Topic','/load_data');
load_data_msgs = readMessages(load_data_topic,'DataFormat','struct');
cat_data = cat(1,load_data_topic.MessageList{:,1});
load_data(:,1) = cat_data;
clear cat_data;
cat_data = cat(1,load_data_msgs{:,1});
load_data(:,2) = cat_data.Data;
clear cat_data;

%Loadcell sensors
frontal_loadcell_data_topic = select(bag_test,'Topic','/frontal_loadcell_data');
frontal_loadcell_data_msgs = readMessages(frontal_loadcell_data_topic,'DataFormat','struct');
posterior_loadcell_data_topic = select(bag_test,'Topic','/posterior_loadcell_data');
posterior_loadcell_data_msgs = readMessages(posterior_loadcell_data_topic,'DataFormat','struct');
cat_data = cat(1,frontal_loadcell_data_topic.MessageList{:,1});
frontal_loadcell_data(:,1) = cat_data;
clear cat_data;
cat_data = cat(1,frontal_loadcell_data_msgs{:,1});
frontal_loadcell_data(:,2) = cat_data.Data;
clear cat_data;
cat_data = cat(1,posterior_loadcell_data_topic.MessageList{:,1});
posterior_loadcell_data(:,1) = cat_data;
clear cat_data;
cat_data = cat(1,posterior_loadcell_data_msgs{:,1});
posterior_loadcell_data(:,2) = cat_data.Data;
clear cat_data;

% Dynamixel Commands
tilt1_command_topic = select(bag_test,'Topic','/tilt1_controller/command');
tilt1_command_msgs = readMessages(tilt1_command_topic,'DataFormat','struct');
tilt2_command_topic = select(bag_test,'Topic','/tilt2_controller/command');
tilt2_command_msgs = readMessages(tilt2_command_topic,'DataFormat','struct');
cat_data = cat(1,tilt1_command_topic.MessageList{:,1});
tilt1_command_data(:,1) = cat_data;
clear cat_data;
cat_data = cat(1,tilt1_command_msgs{:,1});
tilt1_command_data(:,2) = cat_data.Data;
clear cat_data;







