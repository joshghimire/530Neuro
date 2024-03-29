% sample rate 1252 Hz for EEG
% sample rate 32552 Hz for Spikes

% load 2006-6-07_11-26-53.spikeII.mat; spike.t for each detected spike is the time the spike happened?
% spike.shank: 12 shanks, each shank is clustered separately.
%   within each shank, you have the sluster number. 
%   the combination of shank and cluster will identify.

% for every spike, you have the spike time
% for every spike, you have the shank number
% spike.x; xcoordinate of LED when that spike occured. 
% from Hazel: .cluster-> within a shank, groups of electrode activity that were grouped together into the same spike?
% .theta-> was there prominent theta at the time? If so, it's yes. 
% According to kamran, not all of the clusters are the same:
% .qclu- Quality of cluster. 
   % 5 means interneuron
   % 4 means- could include or could exclude
   % 1 and 2 are clean clusters. 

% .ph -> theta phase. 

% assignment-> plot only cells that meet qclu 1 or 2 as a fn of time
% time on x axis. Each row on the y-axis is units. 
    % instead of doing a vertical dash, can start out with a dot every time a neuron spikes
    % then do each neuron in a different color. 


% 2006-6-07_11-26-53.PlaceMax.mat file: 
% 4x20 double. All the cells that meet qclu 1 or 2 criteria. 
% 3rd row-> shank number, 4th row-> cluster number
% 1st and second row-> mystery atm, tbd next class.
% each column is an unit. 
% in .traj, animal running left to right (?) is 3, animal running right to left (?) is 4

% maybe start by looking at first 10 seconds in spike.t:
% 32552 * 10 (as the sampling rate is 32552 Hz)

% Jonathan- Each shank can have the same cluster number. Cluster number corelates to a unit.
% Cluster 13 in shank 1 =/= cluster 13 in shank 2. 