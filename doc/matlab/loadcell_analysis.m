%% Read all trials
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

clear i 
%% Mean values and standar deviation
for i=1:length(trials)
    frontal_loadcell(i).mean = mean(trials(i).matrix_frontal_loadcell.force);
    frontal_loadcell(i).std = std(trials(i).matrix_frontal_loadcell.force);
    frontal_loadcell(i).time.mean = mean(trials(i).matrix_frontal_loadcell.Timestamp);
    frontal_loadcell(i).time.std = std(trials(i).matrix_frontal_loadcell.Timestamp);
    frontal_loadcell(i).name = trials(i).name;
    posterior_loadcell(i).mean = mean(trials(i).matrix_posterior_loadcell.force);
    posterior_loadcell(i).std = std(trials(i).matrix_posterior_loadcell.force);
    posterior_loadcell(i).time.mean = mean(trials(i).matrix_posterior_loadcell.Timestamp);
    posterior_loadcell(i).time.std = std(trials(i).matrix_posterior_loadcell.Timestamp);
    posterior_loadcell(i).name = trials(i).name;
end

%% Plot Trials
font_size_title = 15;
font_size_axis = 12;
colors = ['r','b','g','c','y','k','r','b','g'];

for i=1:length(trials)
    if isnan(strfind(trials(i).name,'FlexExte')) == 0
        figure(1); subplot(2,2,1); hold on;
        u_limit = frontal_loadcell(i).mean + frontal_loadcell(i).std/2;
        d_limit = frontal_loadcell(i).mean - frontal_loadcell(i).std/2;
        jbfill(frontal_loadcell(i).time.mean,u_limit,d_limit,colors(i),colors(i),1,0.3);
        clear u_limit d_limit
        figure(1); subplot(2,2,3); hold on;
        u_limit = posterior_loadcell(i).mean + posterior_loadcell(i).std/2;
        d_limit = posterior_loadcell(i).mean - posterior_loadcell(i).std/2;
        jbfill(posterior_loadcell(i).time.mean,u_limit,d_limit,colors(i),colors(i),1,0.3);
        clear u_limit d_limit
        legend_fe{i} = files(i).name(1:end-4);
    end
    if isnan(strfind(trials(i).name,'Stiffness')) == 0
        figure(1); subplot(2,2,2); hold on;
        u_limit = frontal_loadcell(i).mean + frontal_loadcell(i).std/2;
        d_limit = frontal_loadcell(i).mean - frontal_loadcell(i).std/2;
        jbfill(frontal_loadcell(i).time.mean,u_limit,d_limit,colors(i),colors(i),1,0.3);
        clear u_limit d_limit
        figure(1); subplot(2,2,4); hold on;
        u_limit = posterior_loadcell(i).mean + posterior_loadcell(i).std/2;
        d_limit = posterior_loadcell(i).mean - posterior_loadcell(i).std/2;
        jbfill(posterior_loadcell(i).time.mean,u_limit,d_limit,colors(i),colors(i),1,0.3);
        clear u_limit d_limit
        legend_s{i-6} = files(i).name(1:end-4);
    end
end
figure(1); 
    subplot(2,2,1)
    xlabel('Time [s]','FontSize',font_size_axis,'FontName','Times New Roman', 'Color', 'Black');
    ylabel('Force [N]','FontSize',font_size_axis,'FontName','Times New Roman', 'Color', 'Black');
    title('Frontal tendon response for Flexo-Extension movement','FontSize',font_size_title,'FontName','Times New Roman')
    plots=get(gca, 'Children');
    legend(plots([1, 3, 2, 4, 6, 5]), {'Tendons: 5N','Tendons: 10N','Tendons: 20N','Stiff and Tendons: 5N', 'Stiff and Tendons: 10N','Stiff and Tendons: 20N',});
    subplot(2,2,2)
    xlabel('Time [s]','FontSize',font_size_axis,'FontName','Times New Roman', 'Color', 'Black');
    ylabel('Force [N]','FontSize',font_size_axis,'FontName','Times New Roman', 'Color', 'Black');
    title('Frontal tendon response for Stiffness movement','FontSize',font_size_title,'FontName','Times New Roman')
    plots=get(gca, 'Children');
    legend(plots([1, 3, 2]), {'Tendons: 5N','Tendons: 10N','Tendons: 20N'});
    subplot(2,2,3)
    xlabel('Time [s]','FontSize',font_size_axis,'FontName','Times New Roman', 'Color', 'Black');
    ylabel('Force [N]','FontSize',font_size_axis,'FontName','Times New Roman', 'Color', 'Black');
    title('Posterior tendon response for Flexo-Extension movement','FontSize',font_size_title,'FontName','Times New Roman')
    plots=get(gca, 'Children');
    legend(plots([1, 3, 2, 4, 6, 5]), {'Tendons: 5N','Tendons: 10N','Tendons: 20N','Stiff and Tendons: 5N', 'Stiff and Tendons: 10N','Stiff and Tendons: 20N',});
    subplot(2,2,4)
    xlabel('Time [s]','FontSize',font_size_axis,'FontName','Times New Roman', 'Color', 'Black');
    ylabel('Force [N]','FontSize',font_size_axis,'FontName','Times New Roman', 'Color', 'Black');
    title('Posterior tendon response for Stiffness movement','FontSize',font_size_title,'FontName','Times New Roman')
    plots=get(gca, 'Children');
    legend(plots([1, 3, 2]), {'Tendons: 5N','Tendons: 10N','Tendons: 20N'});
    
clear legend_* plots colors 
%% Percentage of variation
for i=1:length(trials)
   variation_vector(i).frontal(:) = frontal_loadcell(i).std(:).*100./frontal_loadcell(i).mean(:);
   variation_vector(i).posterior(:) = posterior_loadcell(i).std(:).*100./posterior_loadcell(i).mean(:);
   variation(i).frontal = mean(abs(variation_vector(i).frontal(:)));
   variation(i).posterior = mean(abs(variation_vector(i).posterior(:)));
end

clear variation_vector
%% Delay Tendon
% for i=1:length(trials)
%     figure(i); hold on;
%     plot(trials(i).frontal_loadcell_force.Timestamp,trials(i).frontal_loadcell_force.Data);
%     plot(trials(i).tilt1_command_data.Timestamp,-100*trials(i).tilt1_command_data.Data,'*');
%     plot(trials(i).motor_states_frontal.Timestamp,-trials(i).motor_states_frontal.Present_Angle);
%     title(trials(i).name)
% end

for i=1:length(trials)
    figure(i); hold on;
    plot(trials(i).posterior_loadcell_force.Timestamp,trials(i).posterior_loadcell_force.Data);
    plot(trials(i).tilt1_command_data.Timestamp,-100*trials(i).tilt1_command_data.Data,'*');
    plot(trials(i).motor_states_posterior.Timestamp,-trials(i).motor_states_posterior.Present_Angle);
    title(trials(i).name)
end