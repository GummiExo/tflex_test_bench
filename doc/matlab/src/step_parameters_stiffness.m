function [td1, ts1, tr1, tp_min, initial_value1, final_value1, td2, ts2, tr2, tp_max, initial_value2, final_value2, max_peak_value, min_peak_value] = step_parameters_stiffness(input1,input2,output,plot_response)
clc;
clearvars -except input1 input2 plot_response output

%load('data/step_response/Rigid_and_Tendons_FlexExte_Equal_Pretension_5N_step_response')

%output = mean_load;
%input1 = mean_motor_state_frontal;
%input2 = mean_motor_state_posterior;

%% Peaks Values

% Max Peak
[max_peak_value max_peak_pos_output] = max(output.filtered);
tp_max = output.Timestamp(max_peak_pos_output);
%max_peak_pos_input1 = find(input1.Timestamp > tp_max,1) - 1;
%max_peak_pos_input2 = find(input2.Timestamp > tp_max,1) - 1;

% Min Peak
[min_peak_value min_peak_pos_output] = min(output.filtered);
tp_min = output.Timestamp(min_peak_pos_output);
%min_peak_pos_input1 = find(input1.Timestamp > tp_min,1) - 1;
%min_peak_pos_input2 = find(input2.Timestamp > tp_min,1) - 1;

%% Time Values

data_factor = 20; %Data factor after that the command was sent

%Start Time Stiffness
t1_pos_input1 = find(input1.goal_angle ~= 0,1)-1;
t1_input1 = input1.Timestamp(t1_pos_input1);
t1_pos_input2 = find(input2.Timestamp >= t1_input1,1);
t1_pos_output = find(output.Timestamp >= t1_input1,1);
t1 = output.Timestamp(t1_pos_output);

%Final Time Stiffness 

tf1_pos_input1 = find(input1.goal_angle(t1_pos_input1+data_factor:end) ~= input1.goal_angle(t1_pos_input1+data_factor),1) + t1_pos_input1 + data_factor -2 ;
tf1_input1 = input1.Timestamp(tf1_pos_input1);
tf1_pos_input2 = find(input2.Timestamp >= tf1_input1,1);
tf1_pos_output = find(output.Timestamp >= tf1_input1,1);
tf1 = output.Timestamp(tf1_pos_output);

%Start Time Zero position 

t2_pos_input1 = tf1_pos_input1;
t2_input1 = tf1_input1;
t2_pos_input2 = tf1_pos_input2;
t2_pos_output = tf1_pos_output;
t2 = tf1;

%Final Time Zero Position
tf2_pos_input2 = find(input2.goal_angle(t2_pos_input2+data_factor:end) ~= input2.goal_angle(t2_pos_input2+data_factor),1) + t2_pos_input2 + data_factor -2 ;
if isempty(tf2_pos_input2) == 1
    tf2_pos_input2 = length(input2.Timestamp);
end
tf2_input2 = input2.Timestamp(tf2_pos_input2);
%tf2_pos_input1 = find(input1.Timestamp >= tf2_input2,1);
tf2_pos_output = find(output.Timestamp >= tf2_input2,1);
tf2 = output.Timestamp(tf2_pos_output);
if isempty(tf2_pos_output) == 1
    tf2_pos_output = length(output.Timestamp);
    tf2 = output.Timestamp(tf2_pos_output);
    tf2_pos_input2 = find(input2.Timestamp >= tf2,1);
    tf2_input2 = input2.Timestamp(tf2_pos_input2);
    tf2_pos_input1 = find(input1.Timestamp >= tf2,1);
end

%% Stiffness Movement

adjust_pos_final_value = 90;
window_percentage = 3; %Size of window to calculate values

%Final and Initial Values of Torque
initial_value1 = output.filtered(t1_pos_output);
final_value1 = output.filtered(tf1_pos_output - adjust_pos_final_value);

%Move torque data to the y positive axis
output.filtered(:) = output.filtered(:) + abs(min_peak_value);

%Stabilization Positions
window_stabilization1 = abs(window_percentage*final_value1/100);
stabilization_pos1 = intersect(find((output.filtered(min_peak_pos_output:tf1_pos_output)+abs(min_peak_value)) >= (final_value1+abs(min_peak_value) - window_stabilization1)),find(output.filtered(min_peak_pos_output:tf1_pos_output) <= (final_value1+abs(min_peak_value) + window_stabilization1)));
stabilization_pos1 = stabilization_pos1 + min_peak_pos_output -1;

%Stabilization Value
stabilization_value1 = mean(output.filtered(stabilization_pos1) - abs(min_peak_value));

%Move torque data to normal position
output.filtered(:) = output.filtered(:) - abs(min_peak_value);

%Rise Time
rise_time_pos = find(-output.filtered(t1_pos_output:tf1_pos_output) + initial_value1 >= (abs(stabilization_value1) + abs(initial_value1))*0.6,1) + t1_pos_input1 - 1;
tr1 = output.Timestamp(rise_time_pos);  

%Stabilization Time
stabilization_time_pos1 = find(-output.filtered(t1_pos_output:tf1_pos_output) + initial_value1 >= (abs(stabilization_value1) + initial_value1)*1.03,1) + t1_pos_output - 1;
ts1 = output.Timestamp(stabilization_time_pos1);

if isempty(ts1) == 1 || ts1 <= tr1
    stabilization_time_pos1 = find(-output.filtered(t1_pos_output:tf1_pos_output) + initial_value1 >= (abs(stabilization_value1) + initial_value1)*0.97,1) + t1_pos_output - 1;
    ts1 = output.Timestamp(stabilization_time_pos1);
end

%Delay Positions
window_delay1 = abs(1*initial_value1/100);
delay_pos1 = intersect(find(output.filtered(t1_pos_output:tf1_pos_output - data_factor) >= (initial_value1 - window_delay1)),find(output.filtered(t1_pos_output:tf1_pos_output - data_factor) <= (initial_value1 + window_delay1)));
delay_pos1 = delay_pos1 + t1_pos_output -1;

%Delay Value
td1 = mean(output.Timestamp(delay_pos1));

%% Posterior Motor

%Final and Initial Values of Torque
initial_value2 = output.filtered(t2_pos_output);
final_value2 = output.filtered(tf2_pos_output);

%Move torque data to the y positive axis
output.filtered(:) = output.filtered(:) + abs(min_peak_value);

%Stabilization Positions
window_stabilization2 = abs(window_percentage*final_value2/100);
stabilization_pos2 = intersect(find((output.filtered(t2_pos_output:tf2_pos_output))>= (final_value2 + abs(min_peak_value) - window_stabilization2)),find(output.filtered(t2_pos_output:tf2_pos_output) <= (final_value2+abs(min_peak_value) + window_stabilization2)));
stabilization_pos2 = stabilization_pos2 + t2_pos_output -1;

%Stabilization Value
stabilization_value2 = mean(output.filtered(stabilization_pos2) - abs(min_peak_value));

%Move torque data to normal position
output.filtered(:) = output.filtered(:) - abs(min_peak_value);

%Rise Time
rise_time_pos2 = find(output.filtered(t2_pos_output:tf2_pos_output) + abs(initial_value2) >= (abs(stabilization_value2) + abs(initial_value2))*0.6,1) + t2_pos_output - 1;
tr2 = output.Timestamp(rise_time_pos2);  

%Stabilization Time
stabilization_time_pos2 = find(output.filtered(t2_pos_output:tf2_pos_output) + abs(initial_value2) >= abs((abs(stabilization_value2) + initial_value2))*1.03,1) + t2_pos_output - 1;
ts2 = output.Timestamp(stabilization_time_pos2);

if isempty(ts2) == 1 || ts2 <= tr2
    stabilization_time_pos2 = find(output.filtered(t2_pos_output:tf2_pos_output) + abs(initial_value2) >= abs((abs(stabilization_value2) + initial_value2))*0.97,1) + t2_pos_output - 1;
    ts2 = output.Timestamp(stabilization_time_pos2);
end

%Delay Positions
window_delay2 = abs(1*initial_value2/100);
delay_pos2 = intersect(find(output.filtered(t2_pos_output:tf2_pos_output) >= (initial_value2 - window_delay2)),find(output.filtered(t2_pos_output:tf2_pos_output) <= (initial_value2 + window_delay2)));
delay_pos2 = delay_pos2 + t2_pos_output - 1;

%Delay Value
td2 = mean(output.Timestamp(delay_pos2));


%% Plot

if plot_response == "on"
 figure;
 %Data
 plot(input1.Timestamp,input1.goal_angle)
 hold on;
 plot(input2.Timestamp,input2.goal_angle)
 plot(output.Timestamp,output.filtered)
 %Stabilization time
 plot(output.Timestamp(find(output.Timestamp == ts1,1)),output.filtered(find(output.Timestamp == ts1,1)),'o');
 plot(output.Timestamp(find(output.Timestamp == ts2,1)),output.filtered(find(output.Timestamp == ts2,1)),'o');
 %Rise time
 plot(output.Timestamp(find(output.Timestamp == tr1,1)),output.filtered(find(output.Timestamp == tr1,1)),'*');
 plot(output.Timestamp(find(output.Timestamp == tr2,1)),output.filtered(find(output.Timestamp == tr2,1)),'*');
 %Peaks 
 plot(output.Timestamp(max_peak_pos_output),output.filtered(max_peak_pos_output),'*');
 plot(output.Timestamp(min_peak_pos_output),output.filtered(min_peak_pos_output),'*');
 %Delay Values
 plot(output.Timestamp(delay_pos1),output.filtered(delay_pos1),'LineWidth',3);
 plot(output.Timestamp(delay_pos2),output.filtered(delay_pos2),'LineWidth',3);
 legend('Goal Frontal','Goal Posterior','Torque','ts1','ts2','tr1','tr2','max peak','min peak','delay1 values','delay2 values')

end
 
%% Parameters used to calculate time values

%  %Initial and Final Time Frontal Motor
%  vline(t1);
%  vline(tf1)
%  %Window for stabilization value
%  hline(final_value1+window_stabilization1);
%  hline(final_value1-window_stabilization1);
%  %Window for stabilization value
%  plot(output.Timestamp(stabilization_pos1),output.filtered(stabilization_pos1),'LineWidth',3)
%  %Window for delay value
%  hline(initial_value1 - window_delay1);
%  hline(initial_value1 + window_delay1);
%  %Values used to calculate delay value
%  plot(output.Timestamp(delay_pos1),output.filtered(delay_pos1),'LineWidth',3)
% 
%  %Initial and Final Time Posterior Motor
%  vline(t2);
%  vline(tf2)
%  %Window for stabilization value
%  hline(final_value2+window_stabilization2);
%  hline(final_value2-window_stabilization2);
%  %Window for stabilization value
%  plot(output.Timestamp(stabilization_pos2),output.filtered(stabilization_pos2),'LineWidth',3)
%  %Window for delay value
%  hline(initial_value2 - window_delay2);
%  hline(initial_value2 + window_delay2);
%  %Values used to calculate delay value
%  plot(output.Timestamp(delay_pos2),output.filtered(delay_pos2),'LineWidth',3)


%% Adjust time values taking into account the initial time

 ts1 = ts1 - t1;
 tr1 = tr1 -t1;
 tp_min = tp_min - t1;
 td1 = td1 - t1;

 tp_max = tp_max - t2;
 ts2 = ts2 - t2;
 tr2 = tr2 -t2;
 td2 = td2 - t2;


