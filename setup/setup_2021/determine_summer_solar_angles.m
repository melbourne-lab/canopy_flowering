%% 
% Script generating hourly solar angles for Elk Meadows between May and
% August
% For use in stratification for site selection
% SN - 10 May 2021

%% Load in parts and setup

clear; clc; close all;

% Load in functions for SPA
addpath('~/repos/UAV-b-solar-radiation/global/functions')

% Note: needed to install and load System Identification Toolbox

% Specify site average latitude and longitude
% NEON locaton is ~100ft from road bend near NEON plots
lat = 40.030938;
lon = -105.541642;

D2R = pi/180; % convert degrees to radians
R2D = 180/pi; % convert radians to degrees

% time_zone_shift (hours): Time shift relative to UTC (hours)
% NOTE: shifted one hour due to DST
time_zone_shift = -6;

% UTC: Universal Time (Greenwich Mean Time) in decimal hours: 0.0=midnight, 23.0=11pm
% UTC = mod((-1*time_zone_shift) + refHourMDT + (refMinMDT / 60) + 1/4, 24);

% z : elevation (m), approx from reading sensors
z = 3190;

% patm : atmospheric pressure (kPa)
patm = 101.325 * (1-2.25577e-5* z)^5.2559; 
    
spa_in.timezone      = time_zone_shift;
spa_in.delta_ut1     = 0;
spa_in.delta_t       = 67;
spa_in.longitude     = lon;
spa_in.latitude      = lat;
spa_in.elevation     = z;
spa_in.pressure      = patm*10;
spa_in.temperature   = 1;
spa_in.slope         = 0;
spa_in.azm_rotation  = 0;
spa_in.atmos_refract = 0.5667;

% Define hours of day
hours = 8:16;
% Define days (and months corresponding to days)
days  = [1:31, 1:30, 1:31, 1:31];
mnths = [repelem(5, 31), repelem(6, 30), repelem(7, 31), repelem(8, 31)];

% Initialize an object to store results in
summer_angles = zeros(numel(days) * numel(hours), 7);

%% Perform solar positioning

i = 1;
for d = 1:numel(days)
    
    for h = 1:numel(hours)
        
        % enter required input values into SPA structure
        spa_in.year          = 2019;
        spa_in.month         = mnths(d);
        spa_in.day           = days(d);
        spa_in.hour          = hours(h);
        spa_in.minute        = 0;
        spa_in.second        = 0;

        %call the SPA calculate function and pass the SPA structure
        [spa_out] = spa(spa_in);
    
        summer_angles(i, 1) = mnths(d);
        summer_angles(i, 2) = days(d);
        summer_angles(i, 3) = hours(h);
        
        summer_angles(i, 4) = spa_out.zenith;
        summer_angles(i, 5) = spa_out.azimuth;
        summer_angles(i, 6) = spa_out.sunrise;
        summer_angles(i, 7) = spa_out.sunset;
        
        i
        
        i = i + 1;
        
    end
    
end

%% Examine outputs

% First, get rid of any columns with no daylight:
find(summer_angles(:, 3) < summer_angles(:, 6))
find(summer_angles(:, 3) > summer_angles(:, 7))
% None in current running

% Convert to table
summer_angles = array2table(summer_angles);

% Add column names
summer_angles.Properties.VariableNames = { ...
    'Month', 'Day', 'Hour', 'Zenith', 'Azimuth', 'Sunrise', 'sunset' ...
};

% Write output

writetable(summer_angles, 'setup/setup_2021/summer_angles.csv');

