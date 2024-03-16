%% hardcoded values:

% Path handling
analysisPC = 'w';
if analysisPC == 'w'
    addpath(genpath('C:\Users\NaanB\Documents\Matlab\530Neuro\Class Notes\KamranDiba'))
    load('2006-6-07_11-26-53.spikeII.mat')
    load('2006-6-07_11-26-53.PlaceMax.mat')
elseif analysisPC == 'm'
    %addpath(genpath('C:\Users\NaanB\Documents\Matlab\530Neuro\Class Notes\KamranDiba'))
end

% Sample Rates
eegSampleRate = 1252;           % Sample Rate of the EEG Signal in Hz
spikesSampleRate = 32552;       % Sample Rate of Spikes in Hz
recordingDuration = length(spike.t)/spikesSampleRate;   % length of the recording in Seconds
currentTimeBin = 1;             % the time bin in seconds that we want to use atm
bin = spikesSampleRate * currentTimeBin;
binFor_t =  spike.t(1:bin);

%% 
