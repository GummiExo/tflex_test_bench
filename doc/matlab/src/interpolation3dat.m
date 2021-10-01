function [load_interp,frontal_interp,posterior_interp] = interpolation3dat(load,frontal,posterior)

%% Min length

try
    load_data_vector = load.filtered;
    frontal_data = frontal.Present_Angle;
    posterior_data = posterior.Present_Angle;
catch
    load_data_vector = load.data;
    frontal_data = frontal.data;
    posterior_data = posterior.data;
    fprintf("Interpolation General case \n");
end
len_load = length(load_data_vector);
len_frontal = length(frontal_data);
len_posterior = length(posterior_data);

min_length = min(len_load,min(len_frontal,len_posterior));

%% Interpolation cases

if min_length == len_load
    load_interp.filtered = load_data_vector;
    load_interp.Timestamp = load.Timestamp;
    frontal_interp.Present_Angle = interp1(frontal.Timestamp,frontal_data,load.Timestamp);
    %frontal_interp.Goal_Angle = interp1(frontal.Timestamp,frontal.Goal_Angle,load.Timestamp);
    frontal_interp.Timestamp = load.Timestamp;
    posterior_interp.Present_Angle = interp1(posterior.Timestamp,posterior_data,load.Timestamp);
    %posterior_interp.Goal_Angle = interp1(posterior.Timestamp,posterior.Goal_Angle,load.Timestamp);
    posterior_interp.Timestamp = load.Timestamp;
    
elseif min_length == len_frontal
    load_interp.filtered = interp1(load.Timestamp,load_data_vector,frontal.Timestamp);
    load_interp.Timestamp = frontal.Timestamp;
    frontal_interp.Present_Angle = frontal_data;
    %frontal_interp.Goal_Angle = frontal.Goal_Angle;
    frontal_interp.Timestamp = frontal.Timestamp;
    posterior_interp.Present_Angle = interp1(posterior.Timestamp,posterior_data,frontal.Timestamp);
    %posterior_interp.Goal_Angle = interp1(posterior.Timestamp,posterior.Goal_Angle,frontal.Timestamp);
    posterior_interp.Timestamp = frontal.Timestamp;
    
elseif min_length == len_posterior
    load_interp.filtered = interp1(load.Timestamp,load_data_vector,posterior.Timestamp);
    load_interp.Timestamp = posterior.Timestamp;
    frontal_interp.Present_Angle = interp1(frontal.Timestamp,frontal_data,posterior.Timestamp);
    %frontal_interp.Goal_Angle = interp1(frontal.Timestamp,frontal.Goal_Angle,posterior.Timestamp);
    frontal_interp.Timestamp = posterior.Timestamp;
    posterior_interp.Present_Angle = posterior_data;
    %posterior_interp.Goal_Angle = posterior.Goal_Angle;
    posterior_interp.Timestamp = posterior.Timestamp;
end

