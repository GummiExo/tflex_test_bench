clear all; clc; close all;
addpath('./src')
load('data\Human_Trials\Walking\Human_Trials_testbench_application.mat')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  TENDONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Processing Data

cd data/step_response/
trials_dir = '../../../tflex_trials/Human_Trials/Walking/testbench_application.bag';
%data_analysis(trials_dir);
bag = rosbag(trials_dir);
cd ../../

gait_phase_topic = select(bag,'Topic','/gait_phase');
gait_phase_msgs = readMessages(gait_phase_topic,'DataFormat','struct');
cat_data = cat(1,gait_phase_topic.MessageList{:,1});
gait_phase.Timestamp = cat_data;
clear cat_data;
cat_data = cat(1,gait_phase_msgs{:,1});
cat_data = rmfield(cat_data, 'MessageType');
data = struct2table(cat_data);
gait_phase.Data = data.Data;
clear cat_data;
gait_phase = struct2table(cat(1,gait_phase));

imu_data_topic = select(bag,'Topic','/imu_data');
imu_data_msgs = readMessages(imu_data_topic,'DataFormat','struct');
cat_data = cat(1,imu_data_topic.MessageList{:,1});
imu_data.Timestamp = cat_data;
clear cat_data;
cat_data = cat(1,imu_data_msgs{:,1});
cat_data = rmfield(cat_data, 'MessageType');
data = struct2table(cat_data);
imu_data.GyroY = data.GyroY;
clear cat_data;
imu_data = struct2table(cat(1,imu_data));

clear *_topic *_msgs


gait_phase.Timestamp = gait_phase.Timestamp - bag.StartTime;
imu_data.Timestamp = imu_data.Timestamp - bag.StartTime;

SyncTime = tilt1_command_data.Timestamp(1);
gait_phase.TimestampSync = gait_phase.Timestamp - SyncTime;
imu_data.TimestampSync = imu_data.Timestamp - SyncTime;

%%

%close all;
lower_limit = 2250;
%lower_limit = 1;
upper_limit = 2600;
%upper_limit = length(frontal_loadcell_force.Data);
%figure(1)
y = medfilt1(posterior_loadcell_force.Data(lower_limit:upper_limit),1);
time1 = posterior_loadcell_data.Timestamp(lower_limit:upper_limit);
y = lowpass(y,0.001,70);
force1 = y - min(y) + 10;

%plot(time1,y); hold on;
%plot(time1,force1); hold on;

%figure(2)
y2 = medfilt1(frontal_loadcell_force.Data(lower_limit:upper_limit),1);
time2 = frontal_loadcell_data.Timestamp(lower_limit:upper_limit);
y2 = lowpass(y2,0.001,70);
force2 = (y2 - min(y2))/10 + 10;
force2 = lowpass(force2,0.001,70);
%plot(time2,y2)
%plot(time2,force2);

% Y = fft(force2);
% L = length(force2);
% Fs = 70;
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(L/2))/L;
% figure(2)
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')


torque = medfilt1(force2*0.144 - force1*0.138,1);
time_torque = time2;


t1 = time2(1);
t2 = time2(end);
positions = intersect(find(gait_phase.Timestamp>=t1), find(gait_phase.Timestamp<=t2));
p1_gait_phase = positions(1);
p2_gait_phase = positions(end);
time_gait_phase = gait_phase.Timestamp(p1_gait_phase:p2_gait_phase); 
gait_phase_data = gait_phase.Data(p1_gait_phase:p2_gait_phase);

clear positions;
positions = intersect(find(imu_data.Timestamp>=t1), find(imu_data.Timestamp<=t2));
p1_imu_data = positions(1);
p2_imu_data = positions(end);

time_imu = imu_data.Timestamp(p1_imu_data:p2_imu_data);
imu_velocity = medfilt1(imu_data.GyroY(p1_imu_data:p2_imu_data),15);

%figure(4)
%plot(tilt1_command_data.Timestamp,tilt1_command_data.Angle); hold on;
%plot(gait_phase.Timestamp, gait_phase);
%close all;

%figure(3)
%yyaxis left
%plot(time2, torque); hold on;
%plot(gait_phase.Timestamp(p1_gait_phase:p2_gait_phase), gait_phase.Data(p1_gait_phase:p2_gait_phase));
%yyaxis right
%plot(imu_data.Timestamp(p1_imu_data:p2_imu_data),medfilt1(-imu_data.GyroY(p1_imu_data:p2_imu_data),10))

clear positions;
positions = intersect(find(motor_states_frontal.Timestamp>=t1), find(motor_states_frontal.Timestamp<=t2));
p1_motor1 = positions(1);
p2_motor1 = positions(end);
goal_motor1 = motor_states_frontal.Goal(p1_motor1:p2_motor1); %- min(motor_states_frontal.Goal(p1_motor1:p2_motor1));
current_motor1 = motor_states_frontal.Position(p1_motor1:p2_motor1); %- min(motor_states_frontal.Position(p1_motor1:p2_motor1));
load_motor1 = motor_states_frontal.Load_Percentage(p1_motor1:p2_motor1) - min(motor_states_frontal.Load_Percentage(p1_motor1:p2_motor1));
time_motor1 = motor_states_frontal.Timestamp(p1_motor1:p2_motor1);

clear positions;
positions = intersect(find(motor_states_posterior.Timestamp>=t1), find(motor_states_posterior.Timestamp<=t2));
p1_motor2 = positions(1);
p2_motor2 = positions(end);
goal_motor2 = motor_states_posterior.Goal(p1_motor2:p2_motor2); %- min(motor_states_posterior.Goal(p1_motor2:p2_motor2));
current_motor2 = motor_states_posterior.Position(p1_motor2:p2_motor2); % - min(motor_states_posterior.Position(p1_motor2:p2_motor2));
load_motor2 = motor_states_posterior.Load_Percentage(p1_motor2:p2_motor2);
time_motor2 = motor_states_posterior.Timestamp(p1_motor2:p2_motor2);

%figure(4)
%plot(motor_states_frontal.Timestamp(p1_motor1:p2_motor1),goal_motor1,'--');
%hold on;
%yyaxis left
%plot(motor_states_frontal.Timestamp(p1_motor1:p2_motor1),current_motor1);
%plot(motor_states_posterior.Timestamp(p1_motor2:p2_motor2),goal_motor2,'--');
%plot(motor_states_posterior.Timestamp(p1_motor2:p2_motor2),current_motor2);
%yyaxis right
%plot(gait_phase.Timestamp(p1_gait_phase:p2_gait_phase), gait_phase.Data(p1_gait_phase:p2_gait_phase),'-');
%xlabel('Time [s]')
%ylabel('Position [deg]')

%legend('Set-point Frontal', 'Response Frontal', 'Set-point Posterior', 'Response Posterior','Gait phase')

%figure(5)
%plot(motor_states_frontal.Timestamp(p1_motor1:p2_motor1),load_motor1);
frame_size = 0.3;
force_motor1 = (load_motor1/10)/frame_size;
force_motor2 = (load_motor2/10)/frame_size;

torque_ankle1.data = force_motor1*0.144;
torque_ankle1.Timestamp = motor_states_frontal.Timestamp(p1_motor1:p2_motor1); 
torque_ankle2.data = force_motor2*0.138;
torque_ankle2.Timestamp = motor_states_posterior.Timestamp(p1_motor2:p2_motor2);
[test torque_ankle1_sampled torque_ankle2_sampled] = interpolation3dat(torque_ankle1,torque_ankle1,torque_ankle2);

total_torque = torque_ankle1_sampled.Present_Angle - torque_ankle2_sampled.Present_Angle;
%figure(5)
%yyaxis left
%plot(torque_ankle1_sampled.Timestamp,total_torque); hold on;
%plot(gait_phase.Timestamp(p1_gait_phase:p2_gait_phase), gait_phase.Data(p1_gait_phase:p2_gait_phase),'-');
%yyaxis right
%plot(imu_data.Timestamp(p1_imu_data:p2_imu_data),medfilt1(-imu_data.GyroY(p1_imu_data:p2_imu_data),10))

%ankle_angle = cumsum(time_imu, imu_velocity);
%ankle_angle = highpass(ankle_angle,0.001,60) - 23;
%%

figure(1)
subplot(2,1,1);
yyaxis right 
%plot(time_gait_phase,gait_phase_data); hold on;
plot(time_imu,-imu_velocity);


yyaxis left

plot(time_motor1,current_motor1 - 200); hold on;
plot(time_motor1,goal_motor1 - 200); 
plot(time_motor2,current_motor2); 
plot(time_motor2,goal_motor2); 
xlabel('Time [s]');
ylabel('Position [deg]');

legend('motor1 current','motor1 goal','motor2 current','motor2 goal')

subplot(2,1,2);
yyaxis right 
plot(time_gait_phase,gait_phase_data)
yyaxis left
plot(time_torque,torque);
xlabel('Time [s]');
ylabel('Torque [Nm]');

%%
figure;
plot(motor_states_frontal.Goal); hold on;
plot(motor_states_frontal.Position);
%plot(motor_states_frontal.)


%%
torque_filtered = bandpass(torque,[0.1 2],70);
plot(torque_filtered);
