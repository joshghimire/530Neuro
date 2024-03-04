samplingRate = 1000;             % Sampling rate in Hz
maxTime = 1;                     % Maximum time in seconds
samplingInterval = 1/1000;       % One sample per millisecond 
timeVector = samplingInterval:samplingInterval:maxTime;   % 1.Create a time vector of one second with a sampling rate of 1000Hz

spikeRate = 20;                  % Firing Rate
%% Q2. Generate times when spikes occur. 
[spikeSampleIndices, spikeTimes] = generateSpikeTimes(timeVector, spikeRate, samplingRate);

% 2a. Create a plot of spike times using firing rate
spikes = zeros(size(timeVector));
spikes(spikeSampleIndices) = 1;

figure
plot(spikes)
xlabel('Time (ms)')
ylabel('Spike Presence')

%% Q3. 