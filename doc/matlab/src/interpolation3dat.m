function [load_interp,frontal_interp,posterior_interp] = interpolation3dat(load,frontal,posterior)

%% Min length

len_load = length(load.filtered);
len_frontal = length(frontal.Present_Angle);
len_posterior = length(posterior.Present_Angle);

min_length = min(len_load,min(len_frontal,len_posterior));

%% Interpolation cases

if min_length == len_load
    load_interp.filtered = load.filtered;
    load_interp.Timestamp = load.Timestamp;
    frontal_interp.Present_Angle = interp1(frontal.Timestamp,frontal.Present_Angle,load.Timestamp);
    frontal_interp.Goal_Angle = interp1(frontal.Timestamp,frontal.Goal_Angle,load.Timestamp);
    frontal_interp.Timestamp = load.Timestamp;
    posterior_interp.Present_Angle = interp1(posterior.Timestamp,posterior.Present_Angle,load.Timestamp);
    posterior_interp.Goal_Angle = interp1(posterior.Timestamp,posterior.Goal_Angle,load.Timestamp);
    posterior_interp.Timestamp = load.Timestamp;
    
elseif min_length == len_frontal
    load_interp.filtered = interp1(load.Timestamp,load.filtered,frontal.Timestamp);
    load_interp.Timestamp = frontal.Timestamp;
    frontal_interp.Present_Angle = frontal.Present_Angle;
    frontal_interp.Goal_Angle = frontal.Goal_Angle;
    frontal_interp.Timestamp = frontal.Timestamp;
    posterior_interp.Present_Angle = interp1(posterior.Timestamp,posterior.Present_Angle,frontal.Timestamp);
    posterior_interp.Goal_Angle = interp1(posterior.Timestamp,posterior.Goal_Angle,frontal.Timestamp);
    posterior_interp.Timestamp = frontal.Timestamp;
    
elseif min_length == len_posterior
    load_interp.filtered = interp1(load.Timestamp,load.filtered,posterior.Timestamp);
    load_interp.Timestamp = posterior.Timestamp;
    frontal_interp.Present_Angle = interp1(frontal.Timestamp,frontal.Present_Angle,posterior.Timestamp);
    frontal_interp.Goal_Angle = interp1(frontal.Timestamp,frontal.Goal_Angle,posterior.Timestamp);
    frontal_interp.Timestamp = posterior.Timestamp;
    posterior_interp.Present_Angle = posterior.Present_Angle;
    posterior_interp.Goal_Angle = posterior.Goal_Angle;
    posterior_interp.Timestamp = posterior.Timestamp;
end

