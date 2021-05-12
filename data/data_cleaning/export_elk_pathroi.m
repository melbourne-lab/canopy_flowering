%%%%%
% Code for extracting the pathROI and SVF info CSVs
% SN - 1 May 2021
%
% Current version here is operating from a raytrace run done in 2020
% Raytrace was done with DEM and point cloud derived from NEON ALS
% Will be updated periodicially.
%%%%%

%% Setup and data readin

% Set wd (SN only)
cd ~/repos/canopy_flowering

% Clear variables
clear variables

% Load in data
load('./data/solar_data/raytracemod/elk_1m_output.mat')

%% Manipulate and re-shape data

% Linear indices of coordinates (just in case useful)
% Column 1: linear index, Column 2: Easting, Column 3: Northing
% This seems to work for svf but not for ROI?
lininds = horzcat([1:numel(elk_x2)]', elk_x2(:), elk_y2(:));

% Code for linking ROI to coords - from original script (by Keith)
roiMat = nan(size(elk_dem2));
sd = size(elk_dem2);

buff =  [0,  0,  0,  0];

r1 = (buff(1)+1):(sd(1)-buff(2));
c1 = (buff(3)+1):(sd(2)-buff(4));

roiMat(r1,c1) = elk_dem2(r1,c1);

roiInd = find(~isnan(roiMat));

roi_array = [roiInd, elk_x2(roiInd), elk_y2(roiInd)];

roi_table = table(roiInd, elk_x2(roiInd), elk_y2(roiInd), elk_dem2(roiInd));
roi_table.Properties.VariableNames = {'Ind', 'X_e', 'Y_n', 'Z_e'};

% Reshaping the pathROI
% pathROI has number (integer) of voxels that a ray at a certain angle
% passes through to reach that point on the groud
% I want this in long form
pathLong = reshape(pathRoi, [numel(pathRoi), 1]);

size(pathLong)

% Indexing/ordering here is column-wise, e.g.,
% indices 1:3 in reshaped matrix are first, second, third rows in first
% col, first third dim
% in our case, the first 24 entries will cycle through all azimuths
% for the first zenith, first coordinate in space

% Code below for getting azi, zen, and loc for each entry above
% But to be honest that just takes up a lot of space...
[aziazi, zenzen, locloc] = meshgrid(azi, zen, roiInd);
combins = cat(3, aziazi, zenzen, locloc);
combins = reshape(combins, [], 3);
combins = sortrows(combins, [3 2 1]);

% Combine pathROI with other info
pathOut = horzcat(pathLong, combins);

%%% Tried the below... wasn't cooperating. Maybe one day.
% % To save space, narrowing the ROI:
% % NOTE: narrower ROI specified here (based on analysis in sep't script)
% roiLocs = roi_table.Ind(roi_table.X_e < 453950 & ...
%     roi_table.Y_n > 4431275 & roi_table.Y_n < 4431450);
% 
% [locs, indices] = intersect(pathOut(:, 4), roiLocs);
% 
% pathSub = pathOut(indices, :); % only seems to pick out locs once...

% Unroll sky view factor (integrated and estimated transmittance)
% Note: svf is currently based on the default transm polynomial inherited
% from Keith M. Will likely change in future.
% This version is from 2020.
svfLong = horzcat(svf(:), lininds);

%% Export 

% Convert to tables

% first, path lengths
pathOut = array2table(pathOut);
pathOut.Properties.VariableNames = {'PathLen', 'Azi', 'Zen', 'Location'};

% now, svf
svfOut = array2table(svfLong);
svfOut.Properties.VariableNames = {'Svf', 'Location', 'Easting', 'Northing'};

% Export now

writetable(roi_table, 'data/processed_data/elk_roi_key.csv');

writetable(pathOut,   'data/processed_data/elk_roi_pathlengths.csv');

writetable(svfOut,    'data/processed_data/elk_svf.csv');
