samplingRate = 1000;             % Sampling rate in 1000Hz
maxTime = 1;                     % Maximum time in seconds
samplingInterval = 1/1000;       % One sample per millisecond 
timeVector = samplingInterval:samplingInterval:maxTime;   % 1.Create a time vector of one second with a sampling rate of 1000Hz
spikeRate = 20;                  % Firing Rate

spikeSampleIndices = generateSpikeTimes(timeVector, spikeRate, samplingRate);
