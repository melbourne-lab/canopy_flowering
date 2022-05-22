%% Script for running raytrace only for sensor locations at ELK site
% Used in calibrating - getting more precise solar angles and path lengths
% based on script `calibration/isolate_raytrace_finescale.m`
% 
% SN - 21 May 2022
% 
% Step 1: read in sensor locations
% Step 2: get indices in voxelized domain for sensor locations
% Step 3: setup for raytrace loop (copied and pasted directly from old
% script)
% Step 4: run raytrace over sensor locations
% 
% next to add: solar position algorithm and solar position for sensor
% times (fits between steps 1 and 3/4)

% current hiccup - is this doing raytrace at exact angle? or still binned
% angle?
%% Step 1: read in sensor locations (and other info)

% set working directory if needed
% cd ~/Documents/repos/canopy_flowering

% clear namespace
clear

% read in voxelized domain and other materials
load('setup/setup_2022/musselman_calibration/elk_als_voxDomain_20220521.mat');
load('setup/setup_2022/musselman_calibration/elk_als_vda_precursors_20220521.mat');

% read in sensor coordinates
% sensor_places = readtable('calibration/readin_data/sensor_locations_2021-06.csv', ...
%     "Delimiter", "\t");

% Times for calculating solar angles (determined as sunny looking at ref
% sensor data)
% see script: calibration/plot_transmittance_time_series.R
plt_times = readtable('sensors_and_loggers/processed_data/clearsky_transm_2021.csv');

size(plt_times)
% hoo boy big file!

% add functions to path (to get spa())
addpath('setup/musselman_funs/');

% also compile woo raytrace
% Compile the mex function
mex ./setup/musselman_funs/wooRaytrace.cpp % (note: need xcode locally!)

% addpath('~/Documents/MATLAB/Toolboxes/geom3d/geom3d')


%% Step 2: get indices of sensor locations

n_times = size(plt_times, 1);

% get x and y coordinates
elk_x_1d = elk_x2(1,:);
elk_y_1d = elk_y2(:,1);

% initialize columns in sensor places object

plt_times.x_ind = zeros(n_times, 1);
plt_times.y_ind = zeros(n_times, 1);
% coordinate in the DEM (w/ buffer)
plt_times.roi_ind = zeros(n_times, 1); 
% coordinate in ccR, rrR, transRoi
plt_times.index_roi_ind = zeros(n_times, 1);

% loop through sensors and get coordinates and indices
for i = 1:n_times
   
    [~, x_i] = min(abs(elk_x_1d - plt_times.east(i)));
    [~, y_i] = min(abs(elk_y_1d - plt_times.north(i)));
    
    r_i = roiInd_mat(x_i, y_i);
    
    i_i = find(index_roi == r_i);
    
    % [~, sensor_places.x_ind(i)] = min(abs(nwt_x_1d - sensor_places.X_easting(i)));
    % [~, sensor_places.y_ind(i)] = min(abs(nwt_y_1d - sensor_places.Y_northing(i)));
    
    plt_times.x_ind(i) = x_i;
    plt_times.y_ind(i) = y_i;
    plt_times.roi_ind(i) = r_i; 
    plt_times.index_roi_ind(i) = i_i;

    disp(i)
    
end

% s1648_2_x = table2array(sensor_places(7,4));
% s1648_2_y = table2array(sensor_places(7,5));
% s1648_2_i = sensor_places.index_roi_ind(7);
% 
% test_mnth = repelem(10, 60);
% test_date = repelem(3, 60);
% test_hour = repelem(14, 60);
% test_mint = [0:59];
% test_secd = repelem(30, 60);

% Check these on a map

% need to do this first befause this language sucks lmao
sensor_locs = table2array(unique(plt_times(:,{'Plot', 'x_ind', 'y_ind'})));

clf
imagesc(squeeze(sum(voxDomain.ag > 0, 3)))
axis on
hold on
plot(sensor_locs(:,2), sensor_locs(:,3), 'r+', 'LineWidth', 3)
% these look good!

%% Solar angle

patm = 101.325 * (1-2.25577e-5* mean(elk_dem2, 'all'))^5.2559; 

spa_in.timezone      = -6;
spa_in.delta_ut1     = 0;
spa_in.delta_t       = 67;
spa_in.pressure      = patm*10;
spa_in.temperature   = 1;
spa_in.slope         = 0;
spa_in.azm_rotation  = 0;
spa_in.atmos_refract = 0.5667;
spa_in.longitude     = -105.56230;   % center of site - likely won't matter
spa_in.latitude      = 40.03794; % center of site - likely won't matter
spa_in.elevation     = mean(elk_dem2(:));

% Initialize objects for storing angles
azi_ang_deg = zeros(n_times, 1);
zen_ang_deg = zeros(n_times, 1);

% Note: this takes a while
for i = 1:n_times
    
    spa_in.year          = 2021;
    spa_in.month         = plt_times.Month(i);
    spa_in.day           = plt_times.Day(i);
    spa_in.hour          = plt_times.Hour(i);
    spa_in.minute        = plt_times.Minute(i);
    spa_in.second        = 30;
    
    % call the SPA calculate function and pass the SPA structure
    [spa_out] = spa(spa_in);
    
    zen_ang_deg(i) = spa_out.zenith;
    azi_ang_deg(i) = spa_out.azimuth;
    
    if ~rem(i, 100)
        disp(i)
    end
    
    % [zen_ang_err, zen_ang_ind] = min(abs(zen_ang_deg - zen));
    % [azi_ang_err, azi_ang_ind] = min(abs(azi_ang_deg - azi));

end

%% Setup for raytrace step
% see script 01_raytrace_runs/raytrace_NEON_ALS_1m.m (modified from Keith's original script)

% Minimum elevation within the larger domain
minZ = min(elk_dem2(:));% min(voxDomain.z(:));

% Add an optional buffer to all three sides
addit = xygrd/2;

% Define a larger 3D domain around the actual region of interest
gridSize = size(voxDomain.ag);
gridBounds = [0, 0, 0, numel(voxDomain.y)+1, numel(voxDomain.x)+1, numel(voxDomain.z)+1];
% % if plotit == 1
% %     gridImage = zeros(gridSize);
% % end

% Azimuth angles (in radians)
% AziIn(:,1) = azi.*pi/180;
azi_t(:, 1) = azi_ang_deg * (pi/180);
% Zenith angles (radians)
% ZenIn(:,1) = (zen.*pi/180);
zen_t(:, 1) = zen_ang_deg * (pi/180);

% in the subroutine shade azimuth is 0:E, pi/2:N, pi:W, 3pi/2:S
% (for better comparison with the trigonometric circle)
pi2=pi/2.0; % pi/2
pi32=3.0 * pi/2.0; % 3pi/2
p2i=2.0 * pi; % 2pi

% Ensure azimuth is >= 0 and <= 2*pi
azi_t(azi_t > p2i) = azi_t(azi_t > p2i)-p2i;
% Ensure azimuth is not negative
azi_t(azi_t<0) =p2i+azi_t(azi_t<0);

% translate sazimuth % south azimuth?
ind = find(azi_t >= 0  &  azi_t <= pi/2);
if ~isempty(ind)
    azi_t(ind)=pi/2.0-azi_t(ind);
end

ind = find(azi_t > pi/2);
if ~isempty(ind)
    azi_t(ind)=p2i+pi/2.0-azi_t(ind);
end

azi_t = p2i - azi_t;

% Index of rounded indices for use in the transmittance lookup table
AziIn = zeros(n_times, 1);
ZenIn = zeros(n_times, 1);

%   L = createLine3d(P0, THETA, PHI);
%   Create a line with direction given by theta and phi, and which contains point P0. 
% first parameter is a point of the line
% second parameter is angle with the vertical
% third parameter is horizontal angle with Ox axis
%   Line is represented in a parametric form : [x0 y0 z0 dx dy dz]
%   x = x0 + t*dx
%   y = y0 + t*dy;
%   z = z0 + t*dz;
sit = sin(zen_t);
for i = 1:n_times
        
        line{i} = cat(2,cos(azi_t(i)).*sit(i), sin(azi_t(i)).*sit(i), cos(zen_t(i)));
        
        % Also - get indices of rounded angles for transmittance table
        % (this part is slow... could have coded this part better)
        [~, AziIn(i)] = min(abs(azi_ang_deg(i) - azi_t));
        [~, ZenIn(i)] = min(abs(zen_ang_deg(i) - zen_t));
       
        disp(i)
        
end

% Define 3D coordinates of the outer domain
vertices = define_vertices(gridSize, gridBounds);

%% Step 4: Run the raytrace step over sensor positions
% NOTE: will want to change path_temp object to accord with solar angles

% Initialize azi x zen x grid elements
% sensor_paths = single(nan(numel(AziIn),numel(ZenIn), size(sensor_places, 1)));

% outs = [ ...
%     repelem(s1648_2_i, n_times)', ... % index roi for sensor locations
%     azi_t,                       ... % zeniths for times of day/year
%     zen_t,                       ... % azimuths for times of day/year
%     AziIn,                       ... % rounded azimuth indices
%     ZenIn,                       ... % rounded zenith indices
%     repelem(-1, n_times)',        ... % path lengths
%  ];
%[s1641_1_i, zen_ang_ind, azi_ang_ind, -1];

plt_times.path_length = repelem(-1, n_times)';

sensor_hgt = 1.2;

for ij = 1:n_times % ij = 1:size(sensor_places, 1) % Loop through pixels
    % % Comment out the following three lines when running in parallel
    % clc
    if ~rem(ij, 100)
        disp(['Reading ', num2str(ij),' of ', num2str(n_times)])
    end
    
    ii = plt_times.index_roi_ind(ij); % index of sensor location in roi obj.
    azi_ii = azi_t(ij); % true angles
    zen_ii = zen_t(ij);
    aziIn_ii = AziIn(ij); % index of rounded angles for lookup table
    zenIn_ii = ZenIn(ij);
    
    % path_length = -1;
    
    % Removed the transRoi step (comparing with transmittance table)
    % because (1) transmittance is also checked below and (2) the sensors
    % should be high enough above the ground that transmittance is not an
    % issue
    
    % Calculate coordinates of a line starting on the dem at pixel ii
    % with direction defined by azimuth & zenith and intersecting the
    % 3-D box that represents the outer domain
    
    % vertical index for ground height
    % plus one needed for indexing: height of 0 off DEM floor is 1
    vind = voxDomain.dem(iRoi(index_roi(ii))) - minZ + sensor_hgt + 1;
    
    % concatinate the starting point, P0, with the line directions
    lineT = double([ccR(ii)+0.5, rrR(ii)+0.5, vind, line{ij}]);
    
    % Test for intersection of each ray with polygons representing
    % the faces of the outer model domain
    % SN NOTE: requires geom3d to run intersectRayPolygon3d
    % SN - also need to put in 'round2()' function
    % SN - I think this function just kicks you out if any
    % of these produce NaNs.
    
    for k =1:6
        INTER = intersectRayPolygon3d(lineT, vertices{k}); % check vertice config to see if the x and y need to be swapped
        if sum(isnan(INTER)) < 3
            lineCoord = round2(double([lineT(1:3), INTER]),hlfxy);
            INTER = [];
            break
        end
    end
    
    % Trace a line segment defined by two points through a voxel grid
    % (using Woo's raytracing algorithm) and determine linear
    % indices of voxels intersected by the line segment.
    % version 1.0.0.0 (4.75 KB)k by Ivan Klyuzhin
    % A fast algorithm to trace a line segment through a uniform 3D voxel grid.
    % https://www.mathworks.com/matlabcentral/fileexchange/56527-fast-raytracing-through-a-3d-grid
    % Based on the publication: "An efficient and robust ray-box
    % intersection algorithm", A. Williams et al., 2005
    %
    % Inputs
    % First input: dimensions of the voxel grid [Nx Ny Nz]
    % Second input: a 1-by-6 matrix with voxel grid boundaries
    %    [xMin yMin zMin xMax yMax zMax]
    %    (must satisfy xMax>xMin, yMax>yMin, zMax>zMin)
    % Third input: a 1-by-6 matrix with line segment coordinates
    % [x1,y1,z1,x2,y2,z2]
    %
    % Output
    % First output: a N-by-1 matrix containing linear indices of
    % the intersected voxels
    
    % Ensure that lineCoord is within the gridbounds and not
    % exactly on the boundary (causes wooRayTrace to hang)
    lineCoord = lineCoord + 0.053;
    for u = 4:6
        % If the array intersects the outer domain wall beyond the
        % limits, nudge the intersection back within the domain
        if lineCoord(4)<=gridBounds(2)
            lineCoord(4)=gridBounds(2)+0.05;
        elseif lineCoord(5)<=gridBounds(1)
            lineCoord(5)=gridBounds(1)+0.05;
        elseif lineCoord(4)>=gridBounds(5)
            lineCoord(4)=gridBounds(5)-0.05;
        elseif lineCoord(5)>=gridBounds(4)
            lineCoord(5)=gridBounds(5)-0.05;
        elseif lineCoord(6)>=gridBounds(6)
            lineCoord(6)=gridBounds(6)-0.05;
        end
    end
    
    % lineCoord_rev = lineCoord([2 1 3 5 4 6]);
    
    % SN - this is a vector of indices (long) in voxDomain.ag
    % connecting the point on the ground with the bounds of the box
    indices = wooRaytrace(gridSize,gridBounds,lineCoord);
    
    [dyy, dxx, dzz] = ind2sub(gridSize,indices);
    
    % SN - indices outside the boundaries - set to boundaries
    dyy(dyy>gridSize(1))=gridSize(1);
    dxx(dxx>gridSize(2))=gridSize(2);
    dzz(dzz>gridSize(3))=gridSize(3);
    dyy(dyy<1) = 1;
    dxx(dxx<1) = 1;
    dzz(dzz<1) = 1;
    
    % SN - index2 is indices but with points outside the bounds
    % corrected to be inside bounds.
    index2 = sub2ind(size(voxDomain.ag),dyy,dxx,dzz);
    % SN - if there are any 0s on the path (min == 0, ground)
    % if nanmin(voxDomain.ag(index2)) == 0
    %     intersected_inds = [];
    %     path_length = 999;
    % end
    
    voxPath = voxDomain.ag(index2);
    voxPath = voxPath(find(voxPath > 0, 1):end);
    
    %% Determine ground returns & canopy path length
    if sum(voxPath == 0) > 0
        % Ground encountered (before hitting sensor)
        path_length = 999;
    elseif sum(voxPath > 0) > 0
        % Line intersects with no canopy
        path_length = sum(voxPath > 0);
    else
        % No canopy encountered
        path_length = 0;
    end

    plt_times.path_length(ij) = path_length;
end % End the parfor loop through pixels
% toc
% delete(pp);

writetable(plt_times, 'setup/setup_2022/musselman_calibration_path_lens_052122.csv');
% last run/updated/exportedi 2/11/22 on index-adjusted vox domain

