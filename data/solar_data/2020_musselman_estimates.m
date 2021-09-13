%% Script for estimating solar radiation at Elk Meadows w/ Musselman model
% Inputs: raytrace object, plot coordinates + indices
% Outputs: solar radiation estimates at plot locations
% 
% Initially run: 13 Sept 2021
%
% Notes:
% - Initially run on a preliminary version of the raytrace object;
%   will need to be re-run on a properly calibrated model
% - Initially run with daily measurements for each week;
%   may want to run at a different temporal resolution
% - Script is configured to run out of the canopy_flowering GH repo
%
%% Get raytrace estimates

% (Keith's original comment)
% Script to load raytracing results as a 4-D matrix [lat,long,azimuth,zenith]
% of the transmittance of solar radiation, compute the solar geometry for
% specified dates and times, compute clear-sky solar radiation and partition
% between diffuse and direct top-of-canopy irradiance, and estimate the
% direct, diffuse, and total solar radiation (W/m2) for the specified time
% periods.

clear; clc; close all;

% Load the raytracing transmittance and SVF results
% Note: this is uncalibrated from September 2021
load('data/solar_data/elk_als_1m_output.mat');
% Load auxiliary functions
addpath('./setup/musselman_funs')

% Specify site average latitude and longitude
% Here: used point in center of ROI - ~3m NE of gap in center aspen stand
% not sure how sensitive this measurement is
lat = 40.031010;
lon = -105.541534;

D2R = pi/180; % convert degrees to radians
R2D = 180/pi; % convert radians to degrees

% Optionally, load measured reference shortwave radiation, otherwise leave
% variable 'sw' blank.
sw = [];

% Specify dates and times of interest
date(:,1) = datenum('1-may-2020 00:10') : 30/(24*60) : datenum('2-may-2020 00:00');
date(:,2) = datenum('8-may-2020 00:10') : 30/(24*60) : datenum('9-may-2020 00:00');
date(:,3) = datenum('15-may-2020 00:10') : 30/(24*60) : datenum('16-may-2020 00:00');
date(:,4) = datenum('22-may-2020 00:10') : 30/(24*60) : datenum('23-may-2020 00:00');
date(:,5) = datenum('29-may-2020 00:10') : 30/(24*60) : datenum('30-may-2020 00:00');
date(:,6) = datenum('5-jun-2020 00:10') : 30/(24*60) : datenum('6-jun-2020 00:00');
date(:,7) = datenum('12-jun-2020 00:10') : 30/(24*60) : datenum('13-jun-2020 00:00');
date(:,8) = datenum('19-jun-2020 00:10') : 30/(24*60) : datenum('20-jun-2020 00:00');
date(:,9) = datenum('26-jun-2020 00:10') : 30/(24*60) : datenum('27-jun-2020 00:00');

% Day of Year
DV = datevec(date); % Date in vector form
Y = DV(:,1); % Get the year from the date input
DOY = floor(date(:) - datenum(Y,1,1) + 1); % Compute the day-of-year (Jan. 1st = 1)

% time_zone_shift (hours): Time shift relative to UTC (hours)
% -7 (MST) + 1 for daylight saving time
time_zone_shift = -6;

% UTC: Universal Time (Greenwich Mean Time) in decimal hours: 0.0=midnight, 23.0=11pm
UTC = mod((-1*time_zone_shift) + DV(:,4) + DV(:,5)./60 + DV(:,6)./60 , 24);

% z : elevation (m), averaged over DEM
z = nanmean(elk_dem2(:));

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

% Takes a while due to SPA
for i = 1:numel(Y)
    % enter required input values into SPA structure
    spa_in.year          = Y(i);
    spa_in.month         = DV(i,2);
    spa_in.day           = DV(i,3);
    spa_in.hour          = DV(i,4);
    spa_in.minute        = DV(i,5);
    spa_in.second        = DV(i,6);

    %call the SPA calculate function and pass the SPA structure
    % SN - SPA is solar position algorithm (takes in precise time to get
    % the position of the sun and raytrace at that time)
    [spa_out] = spa(spa_in);
    
    zenith_angle_deg(i,1) = spa_out.zenith;
    azimuth_angle_deg(i,1) = spa_out.azimuth;
    sunrise(i,1) = spa_out.sunrise;
    sunset(i,1) = spa_out.sunset;
    solar_decl(i,1) = spa_out.delta.*D2R;
    hour_angle(i,1) = spa_out.h_prime;
end

% % hour_angle = hour_angle*D2R;

% % Determine the solar position based on the date, time & location input
[~,~,~,~,~,hour_angle]=solar_geometry(DOY,UTC,time_zone_shift,lat,lon);

% Determine top-of-atmosphere (TOA) radiation based on date and solar position
RsTOA = TOA_incoming_solar(DOY,UTC,time_zone_shift,lat,lon,zenith_angle_deg);

% If measured SW was not provided, estimate the
% atmospheric transmittance of direct and diffuse radiation
if isempty(sw)
    rad_global=solar_partition_clearsky(solar_decl,D2R*lat,0,0,D2R*zenith_angle_deg,hour_angle,DOY);  
end

% Binary forest-cover map
forest = zeros(size(canopy_height));
forest(canopy_height>0.1) = 1;

% Loop through the dates
for i = 1:numel(date)

    % Interpolate over the transmittance table for a given time step to
    % determine the transmittance map to use for that sun angle.
    trans = interpolate_transmittance(transmittance,azimuth_angle_deg(i)*D2R, ...
    zenith_angle_deg(i)*D2R,azi*D2R,zen*D2R);
    
    % Disaggregate horizontal shortwave to direct and diffuse and project
    % on the local slope
    [Rs(:,:,i),RsDir(:,:,i),RsDif(:,:,i)]=disaggregate_SW(rad_global(i),patm,slope*D2R,...
        aspect*D2R,D2R*zenith_angle_deg(i),D2R*azimuth_angle_deg(i),hour_angle(i),svf,...
        sunrise(i),sunset(i),RsTOA(i),trans,forest);
%     imagesc(Rs(:,:,i)) % 
%     pause(0.1)
%     t=0;
end

% SN - Outputs here:
%   - Rs - solar radiation? total. What is unit? 
%   - RsDir - direct radiation
%   - RsDif - diffuse solar radation
%   all are (x,y) x time 3D arrays

net_subRs_slope = reshape(Rs,[size(elk_dem2,1),size(elk_dem2,2),size(date,1),size(date,2)]);
net_subRs_slope_daily = squeeze(nanmean(net_subRs_slope,3));
