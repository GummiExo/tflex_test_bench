%% Read all trials
clear all; close all; clc;
cd data/step_response/
files = dir('*.mat');

%% Step Parameters
plot_response = "on";
for i=4:length(files)
   load(files(i).name);
   figure(1)
   plot(mean_frontal_loadcell.Data); hold on; 
   figure(2)
   plot(mean_frontal_loadcell.Data); hold on; 
   legend_fig{i-3} = files(i).name(1:end-4);
   legend_fig{i-3} = strrep( legend_fig{i-3}, '_', ' ');
   
end
figure(1); title('Frontal Loadcell');
legend(legend_fig,'Interpreter', 'none');
figure(2); title('Posterior Loadcell');
legend(legend_fig,'Interpreter', 'none');
