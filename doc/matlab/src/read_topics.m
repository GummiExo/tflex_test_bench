function [motor_states_frontal, motor_states_posterior, load_data, frontal_loadcell_data, posterior_loadcell_data, tilt1_command_data, tilt2_command_data] = read_topics(bag)
%function [load_data, frontal_loadcell_data, posterior_loadcell_data, tilt1_command_data, tilt2_command_data] = read_topics(bag)

%     %Dynamixel Motors
    frontal_dynamixel_status_topic = select(bag,'Topic','/motor_states/frontal_tilt_port');
    frontal_dynamixel_status_msgs = readMessages(frontal_dynamixel_status_topic,'DataFormat','struct');
    posterior_dynamixel_status_topic = select(bag,'Topic','/motor_states/posterior_tilt_port');
    posterior_dynamixel_status_msgs = readMessages(posterior_dynamixel_status_topic,'DataFormat','struct');
    cat_data = cat(1,frontal_dynamixel_status_msgs{:,1});
    motor_states_frontal = cat(1,cat_data(:).MotorStates);
    motor_states_frontal = struct2table(rmfield(motor_states_frontal, 'MessageType'));
    clear cat_data;
    cat_data = cat(1,posterior_dynamixel_status_msgs{:,1});
    motor_states_posterior = cat(1,cat_data(:).MotorStates);
    motor_states_posterior = struct2table(rmfield(motor_states_posterior, 'MessageType'));
    clear cat_data; }

    %Torque Sensor
    load_data_topic = select(bag,'Topic','/load_data');
    load_data_msgs = readMessages(load_data_topic,'DataFormat','struct');
    cat_data = cat(1,load_data_topic.MessageList{:,1});
    load_data.Timestamp = cat_data;
    clear cat_data;
    cat_data = cat(1,load_data_msgs{:,1});
    cat_data = rmfield(cat_data, 'MessageType');
    data = struct2table(cat_data);
    load_data.Data = data.Data;
    clear cat_data data;
    load_data = struct2table(cat(1,load_data));

    %Loadcell sensors
    frontal_loadcell_data_topic = select(bag,'Topic','/frontal_loadcell_data');
    frontal_loadcell_data_msgs = readMessages(frontal_loadcell_data_topic,'DataFormat','struct');
    posterior_loadcell_data_topic = select(bag,'Topic','/posterior_loadcell_data');
    posterior_loadcell_data_msgs = readMessages(posterior_loadcell_data_topic,'DataFormat','struct');
    cat_data = cat(1,frontal_loadcell_data_topic.MessageList{:,1});
    frontal_loadcell_data.Timestamp = cat_data;
    clear cat_data;
    cat_data = cat(1,frontal_loadcell_data_msgs{:,1});
    cat_data = rmfield(cat_data, 'MessageType');
    data = struct2table(cat_data);
    frontal_loadcell_data.Data = data.Data;
    clear cat_data data;
    frontal_loadcell_data = struct2table(cat(1,frontal_loadcell_data));
    cat_data = cat(1,posterior_loadcell_data_topic.MessageList{:,1});
    posterior_loadcell_data.Timestamp = cat_data;
    clear cat_data;
    cat_data = cat(1,posterior_loadcell_data_msgs{:,1});
    cat_data = rmfield(cat_data, 'MessageType');
    data = struct2table(cat_data);
    posterior_loadcell_data.Data = data.Data;
    clear cat_data data;
    posterior_loadcell_data = struct2table(cat(1,posterior_loadcell_data));

    % Dynamixel Commands
    tilt1_command_topic = select(bag,'Topic','/tilt1_controller/command');
    tilt1_command_msgs = readMessages(tilt1_command_topic,'DataFormat','struct');
    tilt2_command_topic = select(bag,'Topic','/tilt2_controller/command');
    tilt2_command_msgs = readMessages(tilt2_command_topic,'DataFormat','struct');
    cat_data = cat(1,tilt1_command_topic.MessageList{:,1});
    tilt1_command_data.Timestamp = cat_data;
    clear cat_data;
    cat_data = cat(1,tilt1_command_msgs{:,1});
    cat_data = rmfield(cat_data, 'MessageType');
    data = struct2table(cat_data);
    tilt1_command_data.Data = data.Data;
    clear cat_data;
    tilt1_command_data = struct2table(cat(1,tilt1_command_data));
    cat_data = cat(1,tilt2_command_topic.MessageList{:,1});
    tilt2_command_data.Timestamp = cat_data;
    clear cat_data;
    cat_data = cat(1,tilt2_command_msgs{:,1});
    cat_data = rmfield(cat_data, 'MessageType');
    data = struct2table(cat_data);
    tilt2_command_data.Data = data.Data;
    clear cat_data;
    tilt2_command_data = struct2table(cat(1,tilt2_command_data));

end
