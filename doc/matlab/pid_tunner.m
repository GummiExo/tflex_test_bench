%% Read 20N trial
clear all; close all; clc;
cd data/step_response/
trial1 = load('Tendons_FlexExte_Equal_Pretension_20N_step_response.mat');
trial2 = load('Tendons_FlexExte_Equal_Pretension_20N_step_response2.mat');
trial3 = load('Tendons_FlexExte_Equal_Pretension_20N_step_response3.mat');

%% Plot Motor Responses

figure(1);
    subplot(2,3,1); plot(trial1.mean_motor_state_frontal.Timestamp,trial1.mean_motor_state_frontal.goal_angle); hold on;
                    plot(trial1.mean_motor_state_frontal.Timestamp,trial1.mean_motor_state_frontal.angle);
                    legend('Set Point', 'Motor Angle'); title('Trial 1'); xlabel('Time [s]'); ylabel('Angle [deg]');
    subplot(2,3,2); plot(trial2.mean_motor_state_frontal.Timestamp,trial2.mean_motor_state_frontal.goal_angle); hold on;
                    plot(trial2.mean_motor_state_frontal.Timestamp,trial2.mean_motor_state_frontal.angle);
                    legend('Set Point', 'Motor Angle'); title('Trial 2'); xlabel('Time [s]'); ylabel('Angle [deg]');
    subplot(2,3,3); plot(trial3.mean_motor_state_frontal.Timestamp,trial3.mean_motor_state_frontal.goal_angle); hold on;
                    plot(trial3.mean_motor_state_frontal.Timestamp,trial3.mean_motor_state_frontal.angle);
                    legend('Set Point', 'Motor Angle'); title('Trial 3'); xlabel('Time [s]'); ylabel('Angle [deg]');
    subplot(2,3,4); plot(trial1.mean_motor_state_frontal.goal_angle); hold on;
                    plot(trial1.mean_motor_state_frontal.angle);
                    legend('Set Point', 'Motor Angle'); title('Trial 1'); xlabel('Vector Position'); ylabel('Angle [deg]');
    subplot(2,3,5); plot(trial2.mean_motor_state_frontal.goal_angle); hold on;
                    plot(trial2.mean_motor_state_frontal.angle);
                    legend('Set Point', 'Motor Angle'); title('Trial 2'); xlabel('Vector Position'); ylabel('Angle [deg]');
    subplot(2,3,6); plot(trial3.mean_motor_state_frontal.goal_angle); hold on;
                    plot(trial3.mean_motor_state_frontal.angle);
                    legend('Set Point', 'Motor Angle'); title('Trial 3'); xlabel('Vector Position'); ylabel('Angle [deg]');
%% Sample Time calculator
for i =2:length(trial1.mean_motor_state_frontal.Timestamp)
    sample_vector1(i-1) = trial1.mean_motor_state_frontal.Timestamp(i) - trial1.mean_motor_state_frontal.Timestamp(i-1);
end
mean_sample_trial1 = mean(sample_vector1);

for i =2:length(trial2.mean_motor_state_frontal.Timestamp)
    sample_vector2(i-1) = trial2.mean_motor_state_frontal.Timestamp(i) - trial2.mean_motor_state_frontal.Timestamp(i-1);
end
mean_sample_trial2 = mean(sample_vector2);

for i =2:length(trial3.mean_motor_state_frontal.Timestamp)
    sample_vector3(i-1) = trial3.mean_motor_state_frontal.Timestamp(i) - trial3.mean_motor_state_frontal.Timestamp(i-1);
end
mean_sample_trial3 = mean(sample_vector3);

%% PID Tool
%pidtool

%% Save Plant and Controller
clearvars -except C_trial1 Plant_trial1
%save('data/PID_tuning/plant_pid_controller.mat')

%% Convert to Motor Register
P_gain = C_trial1.Kp/8;
I_gain = C_trial1.Ki*2048/1000;
D_gain = C_trial1.Kd*1000/4;