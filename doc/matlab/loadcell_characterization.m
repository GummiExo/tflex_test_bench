clear all; clc; close all;
addpath('./src')

%% Read Trials
trials_dir_frontal = '../tflex_trials/loadcell_characterization/frontal.bag';
bag_frontal = rosbag(trials_dir_frontal);
trials_dir_posterior = '../tflex_trials/loadcell_characterization/posterior.bag';
bag_posterior = rosbag(trials_dir_posterior);


%% Frontal
frontal_loadcell_data_topic = select(bag_frontal,'Topic','/frontal_loadcell_data');
frontal_loadcell_data_msgs = readMessages(frontal_loadcell_data_topic,'DataFormat','struct');
cat_data = cat(1,frontal_loadcell_data_topic.MessageList{:,1});
frontal_loadcell_data.Timestamp = cat_data;
clear cat_data;
cat_data = cat(1,frontal_loadcell_data_msgs{:,1});
cat_data = rmfield(cat_data, 'MessageType');
data = struct2table(cat_data);
frontal_loadcell_data.Data = data.Data;
clear cat_data data;
frontal_loadcell_data = struct2table(cat(1,frontal_loadcell_data));

len_frontal = length(frontal_loadcell_data.Data);
frontal_loadcell_data.Timestamp = frontal_loadcell_data.Timestamp - bag_frontal.StartTime;
    

%% Posterior
posterior_loadcell_data_topic = select(bag_posterior,'Topic','/posterior_loadcell_data');
posterior_loadcell_data_msgs = readMessages(posterior_loadcell_data_topic,'DataFormat','struct');
cat_data = cat(1,posterior_loadcell_data_topic.MessageList{:,1});
posterior_loadcell_data.Timestamp = cat_data;
clear cat_data;
cat_data = cat(1,posterior_loadcell_data_msgs{:,1});
cat_data = rmfield(cat_data, 'MessageType');
data = struct2table(cat_data);
posterior_loadcell_data.Data = data.Data;
clear cat_data data;
posterior_loadcell_data = struct2table(cat(1,posterior_loadcell_data));

len_posterior = length(posterior_loadcell_data.Data);
posterior_loadcell_data.Timestamp = posterior_loadcell_data.Timestamp - bag_posterior.StartTime;

%% Filters
%frontal_filtered = lowpass(frontal_loadcell_data.Data,0.001,len_frontal/(frontal_loadcell_data.Timestamp(len_frontal) - frontal_loadcell_data.Timestamp(1)));
%posterior_filtered = lowpass(posterior_loadcell_data.Data,0.001,len_posterior/(posterior_loadcell_data.Timestamp(len_posterior) - posterior_loadcell_data.Timestamp(1)));

%% Without Filter
frontal_filtered = frontal_loadcell_data.Data;
posterior_filtered = posterior_loadcell_data.Data;
%% Select Data Frontal

c_fig = figure;
plot(frontal_filtered)
title('Frontal')
ylabel('Voltage')
test_voltage_frontal = zeros(1,7);
for i = 1:7
    fprintf('Select position 1 and press enter then select position 2 and press enter \n')
    cursor = datacursormode(c_fig);
    pause
    value = getCursorInfo(cursor);
    peak1 = value.Position(1);
    pause
    value = getCursorInfo(cursor);
    peak2 = value.Position(1);
    while peak2 <= peak1
            fprintf('Position 2 must be higher than Position 1 = %i \n',peak1)
            pause
            value = getCursorInfo(cursor);
            peak2 = value.Position(1);
    end
    test_voltage_frontal(i) = mean(frontal_filtered(peak1:peak2));

end

%% Select Data Posterior

c2_fig = figure;
%plot(posterior_filtered)
plot(posterior_loadcell_data.Data)
title('Posterior')
ylabel('Voltage')
test_voltage_posterior = zeros(1,7);
for i = 1:7
    fprintf('Select position 1 and press enter then select position 2 and press enter \n')
    cursor = datacursormode(c2_fig);
    pause
    value = getCursorInfo(cursor);
    peak1 = value.Position(1);
    pause
    value = getCursorInfo(cursor);
    peak2 = value.Position(1);
    while peak2 <= peak1
            fprintf('Position 2 must be higher than Position 1 = %i \n',peak1)
            pause
            value = getCursorInfo(cursor);
            peak2 = value.Position(1);
    end
    test_voltage_posterior(i) = mean(posterior_filtered(peak1:peak2));

end

%% Function Frontal

m = [0.04 3.075 3.085 3.142];
F_total_frontal = zeros(1,4);
for i = 2:length(m)
   F_total_frontal(i) = F_total_frontal(i-1) + (m(i))*9.8;
end
p = polyfit(F_total_frontal,test_voltage_frontal(1:4),1);
r = corrcoef(F_total_frontal,test_voltage_frontal(1:4));
r(1,2)
fprintf('V_frontal = %s F_d + %s\n',p(1),p(2));

%% Function Posterior
m2 = [0.04 3.075 3.085 3.142];
F_total_posterior = zeros(1,4);
for i = 2:length(m2)
   F_total_posterior(i) = F_total_posterior(i-1) + (m2(i))*9.8;
end
p2 = polyfit(F_total_posterior,test_voltage_posterior(1:4),1);
r2 = corrcoef(F_total_posterior,test_voltage_posterior(1:4));
r2(1,2)
fprintf('V_posterior = %s F_d + %s\n',p2(1),p2(2));

%% Plots
figure(1);
plot(posterior_loadcell_data.Data); hold on; plot(posterior_filtered); legend('Data','Filtered Data'); hold off

