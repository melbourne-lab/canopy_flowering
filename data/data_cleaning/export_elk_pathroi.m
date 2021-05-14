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
load('./data/solar_data/raytracemod/elk_1m_output_w_roi.mat')

%% Manipulate and re-shape data

% Code for linking ROI to coords - from original script (by Keith)
[rrR(:,1),ccR(:,1)] = ind2sub(size(elk_dem2),index_roi); 

% (4d object for storing path rois)
proi4d = zeros([size(pathRoi, [1 2]), repelem(sqrt(size(pathRoi, 3)), 2)]);

for a = 1:numel(azi) % Loop through the number of azimuth directions
    for z = 1:numel(zen) % Loop through the number of zenith directions
         for ii = 1:numel(index_roi) % Loop through pixels
                 proi4d(a, z, rrR(ii),ccR(ii)) = pathRoi(a,z,ii);
         end
    end
end

% test to make sure this works:
% imagesc(squeeze(proi4d(10, 5, :, :)))

% Create an object for indexing coords
% 
roi_key = zeros([numel(index_roi), 5]);
roi_key(:, 1) = index_roi;

for ii = 1:numel(index_roi)
   roi_key(ii, 2) = rrR(ii);
   roi_key(ii, 3) = ccR(ii);
   roi_key(ii, 4) = elk_x2(rrR(ii), ccR(ii));
   roi_key(ii, 5) = elk_y2(rrR(ii), ccR(ii));
end

% Reshaping the pathROI
% pathROI has number (integer) of voxels that a ray at a certain angle
% passes through to reach that point on the groud
% I want this in long form
pathsLong = reshape(pathRoi, [numel(pathRoi), 1]);

size(pathsLong)

% Indexing/ordering here is column-wise, e.g.,
% indices 1:3 in reshaped matrix are first, second, third rows in first
% col, first third dim
% in our case, the first 24 entries will cycle through all azimuths
% for the first zenith, first coordinate in space

% Code below for getting azi, zen, and loc for each entry above
% But to be honest that just takes up a lot of space...
[aziazi, zenzen, locloc] = meshgrid(azi, zen, 1:size(pathRoi, 3));
combins = cat(3, aziazi, zenzen, locloc);
combins = reshape(combins, [], 3);
combins = sortrows(combins, [3 2 1]);

% Combine pathROI with other info
pathOut = horzcat(pathsLong, combins);

% Remove indices outside the ROI
% First selecting indices
inside_roi = ismember(combins(:, 3), index_roi);
% subsetting out indices
pathOut = pathOut(inside_roi, :);

% To save space, narrowing the ROI:
% NOTE: narrower ROI specified here (based on analysis in sep't script)
roi_subs_locs = roi_key( ...
    roi_key(:,4) < 453950 & roi_key(:,5) > 4431275 & roi_key(:,5) < 4431450, ...
    1);

% Get the rows of pathOut corresponding to the ROI
subs_inds = ismember(pathOut(:, 4), roi_subs_locs);

pathOut_subs = pathOut(subs_inds,:);

% Unroll sky view factor (integrated and estimated transmittance)
% Note: svf is currently based on the default transm polynomial inherited
% from Keith M. Will likely change in future.
% This version is from 2020.
svfLong = horzcat(svf(:), elk_x2(:), elk_y2(:));

%% Export 

% Convert to tables

% first, path lengths
pathOut_subs = array2table(pathOut_subs);
pathOut_subs.Properties.VariableNames = {'PathLen', 'Azi', 'Zen', 'Loc'};

% now, svf
svfOut = array2table(svfLong);
svfOut.Properties.VariableNames = {'Svf', 'Easting', 'Northing'};

% finally the key
roi_key = array2table(roi_key);
roi_key.Properties.VariableNames = {'Loc', 'X_col', 'Y_col', 'X_e', 'Y_n'};

% Export now

writetable(pathOut_subs, 'data/processed_data/elk_roi_pathlengths.csv');

writetable(roi_key,      'data/processed_data/elk_roi_key.csv');

writetable(svfOut,       'data/processed_data/elk_svf.csv');

%% Try this clunky (but hopefully fool-proof) way...

pathsLong = zeros([numel(pathRoi), 7]);
n = 1;
for a = 1:numel(azi) % Loop through the number of azimuth directions
    for z = 1:numel(zen) % Loop through the number of zenith directions
         for ii = 1:size(pathRoi, 3) % Loop through pixels
             pathsLong(n, 1) = ii;
             % pathLong(n, 2) = elk_x2(rrR(ii), ccR(ii));
             % pathLong(n, 3) = elk_y2(rrR(ii), ccR(ii));
             pathsLong(n, 4) = pathRoi(a, z, ii);
             pathsLong(n, 5) = a;
             pathsLong(n, 6) = z;
             [flag_roi, iroi] = ismember(ii, index_roi);
             if flag_roi
                 pathsLong(n, 2) = elk_x2(rrR(iroi), ccR(iroi));
                 pathsLong(n, 3) = elk_y2(rrR(iroi), ccR(iroi));
                 pathsLong(n, 7) = iroi;
             end
             if ~rem(n, 10000)
                 disp(n)
             end
             n = n + 1;
         end
    end
end

% inside_roi = ismember(pathLong(:, 1), index_roi); 
% pathLong = pathLong(inside_roi,:);

% Get the ROI by getting where coords columns are non-zero
proiLong = pathsLong(pathsLong(:, 2) > 0, :);

% To save space, export key linking coordinates to indices
proiKey  = unique(pathsLong(:, [1 2 3 7]), 'rows');

proiKeyTab = array2table(proiKey);
proiKeyTab.Properties.VariableNames = {'GlobInd', 'X_e', 'Y_n', 'RoiInd'};

writetable(proiKeyTab, 'data/processed_data/elk_roi_key.csv');

% Get subsetted data frame (subregion of interest in Elk meadows)
proiSubs = proiLong(...
    proiLong(:,2)<453950 & proiLong(:,3)>4431275 & proiLong(:,3)<4431450, ...
    [1 4 5 6]);

proiSubsTab = array2table(proiSubs);
proiSubsTab.Properties.VariableNames = {'GlobInd', 'PathLen', 'Azi', 'Zen'};

writetable(proiSubsTab, 'data/processed_data/elk_roi_pathlengths.csv');

%% This S still doesn't work (oh my god!!!!)

% (note: This works)

pathsLong = zeros([numel(pathRoi), 6]);

n = 1;
for a = 1:numel(azi) % Loop through the number of azimuth directions
    for z = 1:numel(zen) % Loop through the number of zenith directions
         for ii = 1:numel(index_roi) % Loop through pixels
             pathsLong(n, 1) = ii;
             pathsLong(n, 2) = elk_x2(rrR(ii), ccR(ii));
             pathsLong(n, 3) = elk_y2(rrR(ii), ccR(ii));
             pathsLong(n, 4) = pathRoi(a, z, ii);
             pathsLong(n, 5) = a;
             pathsLong(n, 6) = z;
             if ~rem(n, 10000)
                 disp(n)
             end
             n = n + 1;
         end
    end
end

proiKey  = unique(pathsLong(:, [1 2 3]), 'rows');

proiKeyTab = array2table(proiKey);
proiKeyTab.Properties.VariableNames = {'GlobInd', 'X_e', 'Y_n'};

writetable(proiKeyTab, 'data/processed_data/elk_roi_key.csv');

% Get subsetted data frame (subregion of interest in Elk meadows)
proiSubs = pathsLong(...
    proiLong(:,2)<453950 & proiLong(:,3)>4431275 & proiLong(:,3)<4431450, ...
    [1 4 5 6]);

proiSubsTab = array2table(proiSubs);
proiSubsTab.Properties.VariableNames = {'GlobInd', 'PathLen', 'Azi', 'Zen'};

writetable(proiSubsTab, 'data/processed_data/elk_roi_pathlengths.csv');
