clear all; close all; clc;

%% Read trials

cd data/step_response
trials = dir('*.mat');
for i=1:length(trials)
    step_response(i) = load(trials(i).name);
end

for i=1:length(trials)
    step_response(i).trial_name = trials(i).name;
end

cd ../chirp_response
trials = dir('*.mat');
for i=1:length(trials)
    chirp_response(i) = load(trials(i).name);
end

for i=1:length(trials)
    chirp_response(i).trial_name = trials(i).name;
end


%% Plot Step Response

for i=3:3:length(trials)
    figure(i/3)
        
        %%% Load Data
        subplot(3,4,1:2)
            plot(step_response(i).mean_load.filtered); hold on;
            plot(step_response(i-1).mean_load.filtered); 
            plot(step_response(i-2).mean_load.filtered); 
            legend('Trial 3', 'Trial 2', 'Trial 1');
            title('Torque Ankle')
        subplot(3,4,3)
                plot(step_response(i).mean_frontal_loadcell.Data); hold on;
                plot(step_response(i-1).mean_frontal_loadcell.Data);
                plot(step_response(i-2).mean_frontal_loadcell.Data);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Frontal Tendon Force')
        subplot(3,4,4)
                plot(step_response(i).mean_posterior_loadcell.Data); hold on;
                plot(step_response(i-1).mean_posterior_loadcell.Data);
                plot(step_response(i-2).mean_posterior_loadcell.Data);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Posterior Tendon Force')
        subplot(3,4,5)
                plot(step_response(i).mean_motor_state_frontal.current_filtered); hold on;
                plot(step_response(i-1).mean_motor_state_frontal.current_filtered);
                plot(step_response(i-2).mean_motor_state_frontal.current_filtered);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Frontal Motor Current')
        subplot(3,4,6)
                plot(step_response(i).mean_motor_state_posterior.current_filtered); hold on;
                plot(step_response(i-1).mean_motor_state_posterior.current_filtered);
                plot(step_response(i-2).mean_motor_state_posterior.current_filtered);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Posterior Motor Current')
        subplot(3,4,7)
                plot(step_response(i).mean_motor_state_frontal.load_filtered); hold on;
                plot(step_response(i-1).mean_motor_state_frontal.load_filtered);
                plot(step_response(i-2).mean_motor_state_frontal.load_filtered);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Frontal Motor Load')
        subplot(3,4,8)
                plot(step_response(i).mean_motor_state_posterior.load_filtered); hold on;
                plot(step_response(i-1).mean_motor_state_posterior.load_filtered);
                plot(step_response(i-2).mean_motor_state_posterior.load_filtered);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Posterior Motor Load')
        subplot(3,4,9)
                plot(step_response(i).mean_motor_state_frontal.goal_angle); hold on;
                plot(step_response(i-1).mean_motor_state_frontal.goal_angle);
                plot(step_response(i-2).mean_motor_state_frontal.goal_angle);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Frontal Motor Goal Angle')
        subplot(3,4,10)
                plot(step_response(i).mean_motor_state_posterior.goal_angle); hold on;
                plot(step_response(i-1).mean_motor_state_posterior.goal_angle);
                plot(step_response(i-2).mean_motor_state_posterior.goal_angle);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Posterior Motor Goal Angle')
        subplot(3,4,11)
                plot(step_response(i).mean_motor_state_frontal.angle); hold on;
                plot(step_response(i-1).mean_motor_state_frontal.angle);
                plot(step_response(i-2).mean_motor_state_frontal.angle);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Frontal Motor Angle')
        subplot(3,4,12)
                plot(step_response(i).mean_motor_state_posterior.angle); hold on;
                plot(step_response(i-1).mean_motor_state_posterior.angle);
                plot(step_response(i-2).mean_motor_state_posterior.angle);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Posterior Motor Angle')
         suptitle(strrep(strrep(step_response(i-2).trial_name, '.mat', ''), '_', ' '));
    
end

%% Plot Chirp Response

for i=3:3:length(trials)
    figure(i/3 + (length(trials)-3)/3)
        
        %%% Load Data
        subplot(3,4,1:2)
            plot(chirp_response(i).load_data.Timestamp,chirp_response(i).load_data.filtered); hold on;
            plot(chirp_response(i-1).load_data.Timestamp,chirp_response(i-1).load_data.filtered); 
            plot(chirp_response(i-2).load_data.Timestamp,chirp_response(i-2).load_data.filtered); 
            legend('Trial 3', 'Trial 2', 'Trial 1');
            title('Torque Ankle')
        subplot(3,4,3)
                plot(chirp_response(i).frontal_loadcell_force.Timestamp,chirp_response(i).frontal_loadcell_force.Data); hold on;
                plot(chirp_response(i-1).frontal_loadcell_force.Timestamp,chirp_response(i-1).frontal_loadcell_force.Data);
                plot(chirp_response(i-2).frontal_loadcell_force.Timestamp,chirp_response(i-2).frontal_loadcell_force.Data);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Frontal Tendon Force')
        subplot(3,4,4)
                plot(chirp_response(i).posterior_loadcell_force.Timestamp,chirp_response(i).posterior_loadcell_force.Data); hold on;
                plot(chirp_response(i-1).posterior_loadcell_force.Timestamp,chirp_response(i-1).posterior_loadcell_force.Data);
                plot(chirp_response(i-2).posterior_loadcell_force.Timestamp,chirp_response(i-2).posterior_loadcell_force.Data);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Posterior Tendon Force')
        subplot(3,4,5)
                plot(chirp_response(i).motor_states_frontal.Timestamp,chirp_response(i).motor_states_frontal.Current_filtered); hold on;
                plot(chirp_response(i-1).motor_states_frontal.Timestamp,chirp_response(i-1).motor_states_frontal.Current_filtered);
                plot(chirp_response(i-2).motor_states_frontal.Timestamp,chirp_response(i-2).motor_states_frontal.Current_filtered);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Frontal Motor Current')
        subplot(3,4,6)
                plot(chirp_response(i).motor_states_posterior.Timestamp,chirp_response(i).motor_states_posterior.Current_filtered); hold on;
                plot(chirp_response(i-1).motor_states_posterior.Timestamp,chirp_response(i-1).motor_states_posterior.Current_filtered);
                plot(chirp_response(i-2).motor_states_posterior.Timestamp,chirp_response(i-2).motor_states_posterior.Current_filtered);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Posterior Motor Current')
        subplot(3,4,7)
                plot(chirp_response(i).motor_states_frontal.Timestamp,chirp_response(i).motor_states_frontal.Load_Percentage_filtered); hold on;
                plot(chirp_response(i-1).motor_states_frontal.Timestamp,chirp_response(i-1).motor_states_frontal.Load_Percentage_filtered);
                plot(chirp_response(i-2).motor_states_frontal.Timestamp,chirp_response(i-2).motor_states_frontal.Load_Percentage_filtered);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Frontal Motor Load')
        subplot(3,4,8)
                plot(chirp_response(i).motor_states_posterior.Timestamp,chirp_response(i).motor_states_posterior.Load_Percentage_filtered); hold on;
                plot(chirp_response(i-1).motor_states_posterior.Timestamp,chirp_response(i-1).motor_states_posterior.Load_Percentage_filtered);
                plot(chirp_response(i-2).motor_states_posterior.Timestamp,chirp_response(i-2).motor_states_posterior.Load_Percentage_filtered);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Posterior Motor Load')
        subplot(3,4,9)
                plot(chirp_response(i).motor_states_frontal.Timestamp,chirp_response(i).motor_states_frontal.Goal_Angle); hold on;
                plot(chirp_response(i-1).motor_states_frontal.Timestamp,chirp_response(i-1).motor_states_frontal.Goal_Angle);
                plot(chirp_response(i-2).motor_states_frontal.Timestamp,chirp_response(i-2).motor_states_frontal.Goal_Angle);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Frontal Motor Goal Angle')
        subplot(3,4,10)
                plot(chirp_response(i).motor_states_posterior.Timestamp,chirp_response(i).motor_states_posterior.Goal_Angle); hold on;
                plot(chirp_response(i-1).motor_states_posterior.Timestamp,chirp_response(i-1).motor_states_posterior.Goal_Angle);
                plot(chirp_response(i-2).motor_states_posterior.Timestamp,chirp_response(i-2).motor_states_posterior.Goal_Angle);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Posterior Motor Goal Angle')
        subplot(3,4,11)
                plot(chirp_response(i).motor_states_frontal.Timestamp,chirp_response(i).motor_states_frontal.Present_Angle); hold on;
                plot(chirp_response(i-1).motor_states_frontal.Timestamp,chirp_response(i-1).motor_states_frontal.Present_Angle);
                plot(chirp_response(i-2).motor_states_frontal.Timestamp,chirp_response(i-2).motor_states_frontal.Present_Angle);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Frontal Motor Angle')
        subplot(3,4,12)
                plot(chirp_response(i).motor_states_posterior.Timestamp,chirp_response(i).motor_states_posterior.Present_Angle); hold on;
                plot(chirp_response(i-1).motor_states_posterior.Timestamp,chirp_response(i-1).motor_states_posterior.Present_Angle);
                plot(chirp_response(i-2).motor_states_posterior.Timestamp,chirp_response(i-2).motor_states_posterior.Present_Angle);
                legend('Trial 3', 'Trial 2', 'Trial 1');
                title('Posterior Motor Angle')
         suptitle(strrep(strrep(chirp_response(i-2).trial_name, '.mat', ''), '_', ' '));
    
end