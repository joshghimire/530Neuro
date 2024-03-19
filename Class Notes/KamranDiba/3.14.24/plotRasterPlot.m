%% hardcoded values:

% Path handling
analysisPC = 'm';   % 'w' for windows, 'm' for mac;
if analysisPC == 'w'
    addpath(genpath('C:\Users\NaanB\Documents\Matlab\530Neuro\Class Notes\KamranDiba'))
    load('2006-6-07_11-26-53.spikeII.mat')
    load('2006-6-07_11-26-53.PlaceMax.mat')
elseif analysisPC == 'm'
    addpath(genpath('/Users/joshghimire/Documents/MATLAB/NGP/530Neuro/Class Notes/KamranDiba/3.14.24'))
    load('2006-6-07_11-26-53.spikeII.mat')
    load('2006-6-07_11-26-53.PlaceMax.mat')
end

% Sample Rates
currentTimeBin = 10;             % the time bin in seconds that we want to use atm
eegSampleRate = 1252;           % Sample Rate of the EEG Signal in Hz
spikesSampleRate = 32552;       % Sample Rate of Spikes in Hz
recordingDuration = length(spike.t)/spikesSampleRate;   % length of the recording in Seconds
bin = spikesSampleRate * currentTimeBin;
binFor_t =  spike.t(1:bin);

%% Not using PlaceMax matrix:

% goodSpikeIndices = find(spike.qclu == 1 | spike.qclu == 2);     % find indices of spike.qclu that are either 1 or 2. 
% %timeVectorWithSpikes = zeros(1, length(binFor_t));      % make a row vector of zeors from sample# 1 : length binFor_t of zeros
% %timeVectorWithSpikes(binFor_t') = 1;                    % fill in 1's in the previous row vector when spikes happened.
% goodSpikeShankIndices = spike.shank(goodSpikeIndices);
% goodSpikeClusterIndices = spike.cluster(goodSpikeIndices);

% AHHH THIS IS TOUGH
%% Using PlaceMax matrix:

%Each column of Place Max is one unit
%Row 3: Shank number
%Row 4: Cluster number
%unit_7_shank = PlaceMax(3,7); % this was recorded on the first shank
%unit_7_cluster = PlaceMax(4,7); % this unit was the 21st cluster identified on the first shank
%spike.t(spike.shank == unit_7_shank & spike.cluster == unit_7_cluster);    % Spikes, in units of samples, that were recorded on the first shank and 21st cluster.

for i = 1:length(PlaceMax)
    shankNumber = PlaceMax(3, i);
    clusterNumber = PlaceMax(4, i);
    spikesInUnits{i} = spike.t(spike.shank == shankNumber & spike.cluster == clusterNumber);
    spikesInTime{i} = spikesInUnits{i} / spikesSampleRate;
end

for i = 1:length(spikesInUnits)
    binnedSpikesInUnits{i} = spikesInUnits{i}(spikesInUnits{i} < bin);
    binnedSpikesInTime{i} = spikesInTime{i}(spikesInTime{i} < currentTimeBin);
end

%% Plotting IN TIME

figure
for i = 1:length(binnedSpikesInTime)
    y = (ones(length(binnedSpikesInTime{i}), 1) + i) - 1;
    scatter(binnedSpikesInTime{i}, y, "|")
    hold on;
end
ylim([0 length(PlaceMax)])
ylabel('Neurons')
xlabel('Time (s)')

%% Plotting IN UNITS of SAMPLES

% figure
% for i = 1:length(binnedSpikesInUnits)
%     y = (ones(length(binnedSpikesInUnits{i}), 1) + i) - 1;
%     scatter(binnedSpikesInUnits{i}, y, "|")
%     hold on;
% end
% ylim([0 length(PlaceMax)])
% ylabel('Neurons')
% xlabel('Sample #')
