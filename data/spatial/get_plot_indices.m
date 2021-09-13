%% Get ROI coordinates for 2020 plots
%
% Input: raytrace object, elk meadow plot coordinates for 2020
% Output: elk meadow indices within raytrace object
% In workflow, this will be used to extract radiation estimates for only
% coordinates with plots
%
% SN - 13 Sep 2021
% 
% Note: first run was done with a preliminary raytrace object
% will need to be re-run with a calibrated model

%% Read in data

% cd ~/repos/canopy_flowering/

clear variables

% Raytrace objects
load('data/solar_data/elk_als_1m_output.mat');

% Sensor coordinates
sensor_coords = readtable('data/spatial/2020_plot_coords.csv');

% Remove flight and GCP coords
sensor_coords = sensor_coords(12:end, :);

% Object for number of plots (saves some time)
n_locs = size(sensor_coords, 1);

% get x and y coordinates
x_1d = elk_x2(1,:);
y_1d = elk_y2(:,1);

% re-create the roiInd_mat object
% NOTE: assumes there is no buffer
% if there is a buffer, see the buff() parts of raytrace script and apply
roiMat = reshape(1:numel(elk_x2), size(elk_x2));

% initialize columns in sensor places object

sensor_coords.x_ind = zeros(n_locs, 1);
sensor_coords.y_ind = zeros(n_locs, 1);
% coordinate in the DEM (w/ buffer)
% sensor_coords.roi_ind = zeros(n_locs, 1); 
% coordinate in ccR, rrR, transRoi
sensor_coords.index_roi_ind = zeros(n_locs, 1);

% loop through sensors and get coordinates and indices
for i = 1:n_locs
   
    [~, x_i] = min(abs(x_1d - sensor_coords.X_Easting(i)));
    [~, y_i] = min(abs(y_1d - sensor_coords.Y_Northing(i)));
    
    r_i = roiMat(x_i, y_i);
    
    i_i = find(index_roi == r_i);
    
    % [~, sensor_places.x_ind(i)] = min(abs(nwt_x_1d - sensor_places.X_easting(i)));
    % [~, sensor_places.y_ind(i)] = min(abs(nwt_y_1d - sensor_places.Y_northing(i)));
    
    sensor_coords.x_ind(i) = x_i;
    sensor_coords.y_ind(i) = y_i;
    % sensor_coords.roi_ind(i) = r_i; 
    sensor_coords.index_roi_ind(i) = i_i;
    
end

writetable(sensor_coords, 'data/spatial/2020_plot_coords_roiinds.csv');
