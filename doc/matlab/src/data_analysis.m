%function res = data_analysis(trials_dir)
        
        clearvars -except trials_dir

        %motor_characteristics = ReadYaml('../../../../yaml/tilt.yaml');
        motor_characteristics = ReadYaml('../../yaml/tilt.yaml'); %Executing code directly
        trials_dir = '../tflex_trials/Tendons/FlexExte/Equal_Pretension/5N/step_response.bag';
        
        %% Read Trials

        bag = rosbag(trials_dir);


        %% Read Topics
        [motor_states_frontal, motor_states_posterior, load_data, frontal_loadcell_data, posterior_loadcell_data, frontal_loadcell_force, posterior_loadcell_force, tilt1_command_data, tilt2_command_data] = read_topics(bag);
        %[load_data, frontal_loadcell_data, posterior_loadcell_data, tilt1_command_data, tilt2_command_data] = read_topics(bag);

        %Normalized Timestamp
        motor_states_frontal.Timestamp = motor_states_frontal.Timestamp - bag.StartTime;
        motor_states_posterior.Timestamp = motor_states_posterior.Timestamp - bag.StartTime;
        load_data.Timestamp = load_data.Timestamp - bag.StartTime;
        frontal_loadcell_data.Timestamp = frontal_loadcell_data.Timestamp - bag.StartTime;
        posterior_loadcell_data.Timestamp = posterior_loadcell_data.Timestamp - bag.StartTime;
        frontal_loadcell_force.Timestamp = frontal_loadcell_force.Timestamp - bag.StartTime;
        posterior_loadcell_force.Timestamp = posterior_loadcell_force.Timestamp - bag.StartTime;
        tilt1_command_data.Timestamp = tilt1_command_data.Timestamp - bag.StartTime;
        tilt2_command_data.Timestamp = tilt2_command_data.Timestamp - bag.StartTime;
        
        %% Trial Synchronization
        SyncTime = tilt1_command_data.Timestamp(1);
        
        motor_states_frontal.TimestampSync = motor_states_frontal.Timestamp - SyncTime;
        motor_states_posterior.TimestampSync = motor_states_posterior.Timestamp - SyncTime;
        load_data.TimestampSync = load_data.Timestamp - SyncTime;
        frontal_loadcell_data.TimestampSync = frontal_loadcell_data.Timestamp - SyncTime;
        posterior_loadcell_data.TimestampSync = posterior_loadcell_data.Timestamp - SyncTime;
        frontal_loadcell_force.TimestampSync = frontal_loadcell_force.Timestamp - SyncTime;
        posterior_loadcell_force.TimestampSync = posterior_loadcell_force.Timestamp - SyncTime;
        tilt1_command_data.TimestampSync = tilt1_command_data.Timestamp - SyncTime;
        tilt2_command_data.TimestampSync = tilt2_command_data.Timestamp - SyncTime;
        
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

        % %Filters
        % len_frontal = length(frontal_loadcell_data.Data);
        % len_posterior = length(posterior_loadcell_data.Data);
        % frontal_loadcell_data.filtered = lowpass(frontal_loadcell_data.Data,0.001,len_frontal/(frontal_loadcell_data.Timestamp(len_frontal) - frontal_loadcell_data.Timestamp(1)));
        % posterior_loadcell_data.filtered = lowpass(posterior_loadcell_data.Data,0.001,len_posterior/(posterior_loadcell_data.Timestamp(len_posterior) - posterior_loadcell_data.Timestamp(1)));
        % figure(4)
        % plot(frontal_loadcell_data.Timestamp, frontal_loadcell_data.filtered); hold on; plot(posterior_loadcell_data.Timestamp,posterior_loadcell_data.filtered); legend('Frontal','Posterior'); title('Loadcell Data Filtered');
        % 
        % frontal_initial_voltage = 3.421;
        % factor_frontal = 0.0003329729;
        % posterior_initial_voltage = 1.802;
        % factor_posterior = 0.0006506158;
        % frontal_loadcell_data.Force = ((frontal_loadcell_data.filtered - frontal_initial_voltage)/factor_frontal);
        % posterior_loadcell_data.Force = ((posterior_loadcell_data.filtered - posterior_initial_voltage)/factor_posterior);
        % 
        % %Tendon Force
        % frontal_inclination = deg2rad(97);
        % frontal_loadcell_data.Tendon_Force = frontal_loadcell_data.Force/sin(frontal_inclination);
        % posterior_inclination = deg2rad(82);
        % posterior_loadcell_data.Tendon_Force = posterior_loadcell_data.Force/sin(posterior_inclination);

        %figure(4)
        %plot(frontal_loadcell_force.Timestamp, frontal_loadcell_force.Data); hold on; plot(posterior_loadcell_force.Timestamp,posterior_loadcell_force.Data); legend('Frontal','Posterior'); title('Loadcell Force');


        %% Data processing

        load_data.filtered = medfilt1(load_data.Data,5);
        motor_states_frontal.Load_Percentage_filtered = medfilt1(motor_states_frontal.Load_Percentage,4);
        motor_states_posterior.Load_Percentage_filtered = medfilt1(motor_states_posterior.Load_Percentage,4);
        motor_states_frontal.Current_filtered = medfilt1(motor_states_frontal.Current,5);
        motor_states_posterior.Current_filtered = medfilt1(motor_states_posterior.Current,4);

        %% Mean Data for Step Response
        [peaks.value peaks.position] = findpeaks(-motor_states_frontal.Goal_Angle,'MinPeakDistance', 70);
        peaks.value(1) = [];
        peaks.position(1) = [];
        peaks.time = motor_states_frontal.TimestampSync(peaks.position);
        factor_seconds = 0.05;

%         figure;
%         subplot(2,1,1); plot(motor_states_frontal.TimestampSync,-motor_states_frontal.Goal_Angle); hold on; plot(peaks.time,peaks.value,'*');
%                         plot(motor_states_frontal.TimestampSync,-motor_states_frontal.Present_Angle);
%         subplot(2,1,2); plot(load_data.TimestampSync,load_data.Data); hold on; plot(peaks.time,peaks.value,'*');
%         
        
        %%% Find Position of Peaks
        for i = 2:length(peaks.position)
            %%%% Frontal Motor
            pos1_frontal = find(motor_states_frontal.TimestampSync > (peaks.time(i-1) - factor_seconds));
            pos2_frontal = find(motor_states_frontal.TimestampSync < (peaks.time(i) + factor_seconds));
            pos_values_frontal = intersect(pos1_frontal(:,1),pos2_frontal(:,1));
            size_pos_values_frontal(i-1) = length(pos_values_frontal);

            %%%% Posterior Motor

            pos1_posterior = find(motor_states_posterior.TimestampSync > (peaks.time(i-1) - factor_seconds));
            pos2_posterior = find(motor_states_posterior.TimestampSync < (peaks.time(i) + factor_seconds));
            pos_values_posterior = intersect(pos1_posterior(:,1),pos2_posterior(:,1));
            size_pos_values_posterior(i-1) = length(pos_values_posterior);

            %%%% Ankle Load

            pos1_load = find(load_data.TimestampSync > (peaks.time(i-1) - factor_seconds));
            pos2_load = find(load_data.TimestampSync < (peaks.time(i) + factor_seconds));
            pos_values_load = intersect(pos1_load(:,1),pos2_load(:,1));
            size_pos_values_load(i-1) = length(pos_values_load);
            
                   
            %%%% Loadcells

            pos1_frontal_loadcell = find(frontal_loadcell_force.TimestampSync > (peaks.time(i-1) - factor_seconds));
            pos2_frontal_loadcell = find(frontal_loadcell_force.TimestampSync < (peaks.time(i) + factor_seconds));
            pos_values_frontal_loadcell = intersect(pos1_frontal_loadcell(:,1),pos2_frontal_loadcell(:,1));
            size_pos_values_frontal_loadcell(i-1) = length(pos_values_frontal_loadcell);
            
            
            pos1_posterior_loadcell = find(posterior_loadcell_force.TimestampSync > (peaks.time(i-1) - factor_seconds));
            pos2_posterior_loadcell = find(posterior_loadcell_force.TimestampSync < (peaks.time(i) + factor_seconds));
            pos_values_posterior_loadcell = intersect(pos1_posterior_loadcell(:,1),pos2_posterior_loadcell(:,1));
            size_pos_values_posterior_loadcell(i-1) = length(pos_values_posterior_loadcell);
            
        end
        
        angle_frontal_matrix = zeros(length(peaks.position),min(size_pos_values_frontal));
        goal_angle_frontal_matrix = zeros(length(peaks.position),min(size_pos_values_frontal));
        load_filtered_frontal_matrix = zeros(length(peaks.position),min(size_pos_values_frontal));
        current_filtered_frontal_matrix = zeros(length(peaks.position),min(size_pos_values_frontal));
        load_frontal_matrix = zeros(length(peaks.position),min(size_pos_values_frontal));
        current_frontal_matrix = zeros(length(peaks.position),min(size_pos_values_frontal));
        motor_frontal_timestamp_matrix =zeros(length(peaks.position),min(size_pos_values_frontal));
        
        angle_posterior_matrix = zeros(length(peaks.position),min(size_pos_values_posterior));
        goal_angle_posterior_matrix = zeros(length(peaks.position),min(size_pos_values_posterior));
        load_filtered_posterior_matrix = zeros(length(peaks.position),min(size_pos_values_posterior));
        current_filtered_posterior_matrix = zeros(length(peaks.position),min(size_pos_values_posterior));
        load_posterior_matrix = zeros(length(peaks.position),min(size_pos_values_posterior));
        current_posterior_matrix = zeros(length(peaks.position),min(size_pos_values_posterior));
        motor_posterior_timestamp_matrix = zeros(length(peaks.position),min(size_pos_values_posterior));
        
        load_matrix = zeros(length(peaks.position),min(size_pos_values_load));
        load_filtered_matrix =  zeros(length(peaks.position),min(size_pos_values_load));
        load_timestamp_matrix = zeros(length(peaks.position),min(size_pos_values_load));
        
        frontal_loadcell_matrix = zeros(length(peaks.position),min(size_pos_values_frontal_loadcell));
        frontal_loadcell_timestamp_matrix = zeros(length(peaks.position),min(size_pos_values_frontal_loadcell));
        
        posterior_loadcell_matrix = zeros(length(peaks.position),min(size_pos_values_posterior_loadcell));
        posterior_loadcell_timestamp_matrix = zeros(length(peaks.position),min(size_pos_values_posterior_loadcell));
        
        %%% Cut Data

        for i=1:length(peaks.position)
            pos1_frontal = find(motor_states_frontal.TimestampSync >= peaks.time(i) - factor_seconds);
            angle_frontal_matrix(i,:) = motor_states_frontal.Present_Angle(pos1_frontal(1):pos1_frontal(1)+min(size_pos_values_frontal)-1);
            goal_angle_frontal_matrix(i,:) = motor_states_frontal.Goal_Angle(pos1_frontal(1):pos1_frontal(1)+min(size_pos_values_frontal)-1);
            load_filtered_frontal_matrix(i,:) = motor_states_frontal.Load_Percentage_filtered(pos1_frontal(1):pos1_frontal(1)+min(size_pos_values_frontal)-1);
            current_filtered_frontal_matrix(i,:) = motor_states_frontal.Current_filtered(pos1_frontal(1):pos1_frontal(1)+min(size_pos_values_frontal)-1);
            load_frontal_matrix(i,:) = motor_states_frontal.Load_Percentage(pos1_frontal(1):pos1_frontal(1)+min(size_pos_values_frontal)-1);
            current_frontal_matrix(i,:) = motor_states_frontal.Current(pos1_frontal(1):pos1_frontal(1)+min(size_pos_values_frontal)-1);
            motor_frontal_timestamp_matrix(i,:) = motor_states_frontal.TimestampSync(pos1_frontal(1):pos1_frontal(1)+min(size_pos_values_frontal)-1);
            motor_frontal_timestamp_matrix(i,:) = motor_frontal_timestamp_matrix(i,:) - motor_frontal_timestamp_matrix(i,1);
            
            pos1_posterior = find(motor_states_posterior.TimestampSync >= peaks.time(i) - factor_seconds);
            angle_posterior_matrix(i,:) = motor_states_posterior.Present_Angle(pos1_posterior(1):pos1_posterior(1)+min(size_pos_values_posterior)-1);
            goal_angle_posterior_matrix(i,:) = motor_states_posterior.Goal_Angle(pos1_posterior(1):pos1_posterior(1)+min(size_pos_values_posterior)-1);
            load_filtered_posterior_matrix(i,:) = motor_states_posterior.Load_Percentage_filtered(pos1_posterior(1):pos1_posterior(1)+min(size_pos_values_posterior)-1);
            current_filtered_posterior_matrix(i,:) = motor_states_posterior.Current_filtered(pos1_posterior(1):pos1_posterior(1)+min(size_pos_values_posterior)-1);
            load_posterior_matrix(i,:) = motor_states_posterior.Load_Percentage(pos1_posterior(1):pos1_posterior(1)+min(size_pos_values_posterior)-1);
            current_posterior_matrix(i,:) = motor_states_posterior.Current(pos1_posterior(1):pos1_posterior(1)+min(size_pos_values_posterior)-1);
            motor_posterior_timestamp_matrix(i,:) = motor_states_posterior.TimestampSync(pos1_posterior(1):pos1_posterior(1)+min(size_pos_values_posterior)-1);
            motor_posterior_timestamp_matrix(i,:) = motor_posterior_timestamp_matrix(i,:) - motor_posterior_timestamp_matrix(i,1);
            
            pos1_load = find(load_data.TimestampSync >= peaks.time(i) - factor_seconds);
            load_matrix(i,:) = load_data.Data(pos1_load(1):pos1_load(1)+min(size_pos_values_load)-1);
            load_filtered_matrix(i,:) = load_data.filtered(pos1_load(1):pos1_load(1)+min(size_pos_values_load)-1);
            load_timestamp_matrix(i,:) = load_data.TimestampSync(pos1_load(1):pos1_load(1)+min(size_pos_values_load)-1);
            load_timestamp_matrix(i,:) = load_timestamp_matrix(i,:) - load_timestamp_matrix(i,1);
            
            pos1_frontal_loadcell = find(frontal_loadcell_force.TimestampSync >= peaks.time(i) - factor_seconds);
            pos1_posterior_loadcell = find(posterior_loadcell_force.TimestampSync >= peaks.time(i) - factor_seconds);
            frontal_loadcell_matrix(i,:) = frontal_loadcell_force.Data(pos1_frontal_loadcell(1):pos1_frontal_loadcell(1)+min(size_pos_values_frontal_loadcell)-1);
            frontal_loadcell_timestamp_matrix (i,:) = frontal_loadcell_force.TimestampSync(pos1_frontal_loadcell(1):pos1_frontal_loadcell(1)+min(size_pos_values_frontal_loadcell)-1);
            frontal_loadcell_timestamp_matrix (i,:) = frontal_loadcell_timestamp_matrix (i,:) - frontal_loadcell_timestamp_matrix (i,1);
            posterior_loadcell_matrix(i,:) = posterior_loadcell_force.Data(pos1_posterior_loadcell(1):pos1_posterior_loadcell(1)+min(size_pos_values_posterior_loadcell)-1);
            posterior_loadcell_timestamp_matrix (i,:) = posterior_loadcell_force.TimestampSync(pos1_posterior_loadcell(1):pos1_posterior_loadcell(1)+min(size_pos_values_posterior_loadcell)-1);
            posterior_loadcell_timestamp_matrix (i,:) = posterior_loadcell_timestamp_matrix (i,:) - posterior_loadcell_timestamp_matrix (i,1);
        end

        %%%% Frontal Motor
        mean_motor_state_frontal.Timestamp = mean(motor_frontal_timestamp_matrix);
        mean_motor_state_frontal.angle = mean(angle_frontal_matrix);
        mean_motor_state_frontal.goal_angle = mean(goal_angle_frontal_matrix);
        mean_motor_state_frontal.load_filtered = mean(load_filtered_frontal_matrix);
        mean_motor_state_frontal.current_filtered = mean(current_filtered_frontal_matrix);
        mean_motor_state_frontal.load = mean(load_frontal_matrix);
        mean_motor_state_frontal.current = mean(current_frontal_matrix);

        %%%% Posterior Motor
        mean_motor_state_posterior.Timestamp = mean(motor_posterior_timestamp_matrix);
        mean_motor_state_posterior.angle = mean(angle_posterior_matrix);
        mean_motor_state_posterior.goal_angle = mean(goal_angle_posterior_matrix);
        mean_motor_state_posterior.load_filtered = mean(load_filtered_posterior_matrix);
        mean_motor_state_posterior.current_filtered = mean(current_filtered_posterior_matrix);
        mean_motor_state_posterior.load = mean(load_posterior_matrix);
        mean_motor_state_posterior.current = mean(current_posterior_matrix);

        %%%% Torque Sensor
        mean_load.Timestamp = mean(load_timestamp_matrix);
        mean_load.Data = mean(load_matrix);
        mean_load.filtered = mean(load_filtered_matrix);

        %%%% Loadcells
        mean_frontal_loadcell.Timestamp = mean(frontal_loadcell_timestamp_matrix);
        mean_frontal_loadcell.Data = mean(frontal_loadcell_matrix);
        mean_posterior_loadcell.Timestamp = mean(posterior_loadcell_timestamp_matrix);
        mean_posterior_loadcell.Data = mean(posterior_loadcell_matrix);

        %% Mean Processing
        mean_load.filtered = medfilt1(mean_load.filtered,40);

          %% Plots
%         %Goal vs Present Position
%         figure(1); 
%             title('Motor Position');
%             subplot(1,2,1); plot(motor_states_frontal.Timestamp, motor_states_frontal.Goal_Angle); hold on; plot(motor_states_frontal.Timestamp, motor_states_frontal.Present_Angle);
%             subplot(1,2,2); plot(motor_states_posterior.Timestamp, motor_states_posterior.Goal_Angle); hold on; plot(motor_states_posterior.Timestamp, motor_states_posterior.Present_Angle);
%             
%             
%         %Force Tendon
%         figure(2)
%             title('Force Tendon');
%             plot(frontal_loadcell_force.Timestamp,frontal_loadcell_force.Data); hold on;
%             plot(posterior_loadcell_force.Timestamp,posterior_loadcell_force.Data);
%             legend('Frontal','Posterior');
%             
%         
%         %Torque Sensor
%         figure(3)
%             subplot(3,1,1); %plot(load_data.Timestamp,load_data.Data); hold on;
%                             plot(load_data.Timestamp,load_data.filtered)
%                             title('Ankle Torque');
%                             %legend('Data', 'Filtered')
%                             
%             subplot(3,1,2); plot(motor_states_frontal.Timestamp,motor_states_frontal.Load_Percentage_filtered); hold on;
%                             plot(motor_states_posterior.Timestamp,motor_states_posterior.Load_Percentage_filtered);
%                             title('Motor Load');
%                             
%             subplot(3,1,3); plot(motor_states_frontal.Timestamp,motor_states_frontal.Current_filtered); hold on;
%                             plot(motor_states_posterior.Timestamp,motor_states_posterior.Current_filtered);
%                             title('Motor Current');
%                             legend('Frontal','Posterior');
%                             %plot(motor_states_frontal.Timestamp,motor_states_frontal.Current)
%                             %plot(motor_states_posterior.Timestamp,motor_states_posterior.Current)
%                             %legend('Frontal Filtered','Posterior Filtered','Frontal','Posterior')
%                             
%         %Mean Values
%         figure; 
%             subplot(5,2,1); plot(mean_motor_state_frontal.Timestamp,mean_motor_state_frontal.goal_angle); hold on; plot(mean_motor_state_frontal.Timestamp,mean_motor_state_frontal.angle); title('Frontal Motor Angle');
%             subplot(5,2,2); plot(mean_motor_state_posterior.Timestamp,mean_motor_state_posterior.goal_angle); hold on; plot(mean_motor_state_posterior.Timestamp,mean_motor_state_posterior.angle); title('Posterior Motor Angle');
%             subplot(5,2,3); plot(mean_motor_state_frontal.Timestamp,mean_motor_state_frontal.current); hold on; plot(mean_motor_state_frontal.Timestamp,mean_motor_state_frontal.current_filtered); legend('Data','Filtered'); title('Frontal Motor Current');
%             subplot(5,2,4); plot(mean_motor_state_posterior.Timestamp,mean_motor_state_posterior.current); hold on; plot(mean_motor_state_posterior.Timestamp,mean_motor_state_posterior.current_filtered); legend('Data','Filtered'); title('Posterior Motor Current');
%             subplot(5,2,5); plot(mean_motor_state_frontal.Timestamp,mean_motor_state_frontal.load); hold on; plot(mean_motor_state_frontal.Timestamp,mean_motor_state_frontal.load_filtered); legend('Data','Filtered'); title('Frontal Motor Load');
%             subplot(5,2,6); plot(mean_motor_state_posterior.Timestamp,mean_motor_state_posterior.load); hold on; plot(mean_motor_state_posterior.Timestamp,mean_motor_state_posterior.load_filtered); legend('Data','Filtered'); title('Posterior Motor Load');
%             subplot(5,2,7:8); plot(mean_load.Timestamp, mean_load.Data); hold on; plot(mean_load.Timestamp, mean_load.filtered); legend('Data','Filtered'); title('Torque Sensor');
%             subplot(5,2,9:10); plot(mean_frontal_loadcell.Timestamp,mean_frontal_loadcell.Data); hold on; plot(mean_posterior_loadcell.Timestamp,mean_posterior_loadcell.Data); legend('Frontal','Posterior'); title('Loadcell Data')
        
        %% Clean Workspace

        %clear *_matrix pos1* pos2* pos_* size* peaks i bag motor_characteristics SyncTime s factor_seconds;

        %% Save Data

        s = strfind(trials_dir,'/');
        name_file = string(trials_dir(s(2)+1:s(3)-1));
        for i=5:length(s)
            name_file = name_file + "_" + string(trials_dir(s(i-1)+1:s(i)-1));
        end
        name_file = name_file + "_" + string(trials_dir(s(i)+1:length(trials_dir)-4));
        name_file = strrep(name_file,'.._','');
        clear s i trials_dir;
        name_file = "./" +name_file;
        save(name_file, '-regexp', '^(?!(name_file)$).');
        res = 1;