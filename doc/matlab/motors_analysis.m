clear all; %close all; clc;
cd data/step_response/
files = dir('*.mat');

%% Load trials
for i=1:length(files)
   trials(i) = load(files(i).name);
end
for i=1:length(files)
   trials(i).name = files(i).name;
end

%% Current
for i=1:length(trials)
   current(i).frontal = trials(i).mean_motor_state_frontal.current_filtered;
   current(i).posterior = trials(i).mean_motor_state_posterior.current_filtered;
   current(i).name = trials(i).name;

   current(i).mean_frontal = mean(abs(current(i).frontal));
   current(i).mean_posterior = mean(abs(current(i).posterior));
   current(i).max_frontal = max(abs(current(i).frontal));
   current(i).max_posterior = max(abs(current(i).posterior));
   %plot(current(i).frontal); hold on;
end

%% Voltage

for i=1:length(trials)
   voltage(i).frontal = medfilt1(trials(i).motor_states_frontal.Voltage,10);
   voltage(i).posterior = medfilt1(trials(i).motor_states_posterior.Voltage,10);
   voltage(i).name = trials(i).name;

   voltage(i).mean_frontal = mean(abs(voltage(i).frontal));
   voltage(i).mean_posterior = mean(abs(voltage(i).posterior));
   voltage(i).max_frontal = max(abs(voltage(i).frontal));
   voltage(i).max_posterior = max(abs(voltage(i).posterior));
   %plot(voltage(i).frontal); hold on;
end

%% Load

for i=1:length(trials)
   load(i).frontal = trials(i).mean_motor_state_frontal.load_filtered;
   load(i).posterior = trials(i).mean_motor_state_posterior.load_filtered;
   load(i).name = trials(i).name;

   load(i).mean_frontal = mean(abs(load(i).frontal));
   load(i).mean_posterior = mean(abs(load(i).posterior));
   load(i).max_frontal = max(abs(load(i).frontal));
   load(i).max_posterior = max(abs(load(i).posterior));
   %plot(load(i).frontal); hold on;
end

%% Temperature

%% Voltage

for i=1:length(trials)
   temperature(i).frontal = medfilt1(double(trials(i).motor_states_frontal.Temperature_),1);
   temperature(i).posterior = medfilt1(double(trials(i).motor_states_posterior.Temperature_),1);
   temperature(i).name = trials(i).name;

   temperature(i).mean_frontal = mean(abs(temperature(i).frontal));
   temperature(i).mean_posterior = mean(abs(temperature(i).posterior));
   temperature(i).max_frontal = max(abs(temperature(i).frontal));
   temperature(i).max_posterior = max(abs(temperature(i).posterior));
   %plot(temperature(i).frontal); hold on;
end
