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
ylim([0 1])
title('Spikes vs. Time')
%% Q3. generate voltageTrace for all time points
waveform = [0.0, -0.6, -1, -0.8, 0.2, 0.8, 0.7, 0.4, 0.2, 0.1, 0];  % waveform for voltage traces
voltageTrace = zeros(size(timeVector));                             % voltageTrace vector stores voltage at each timepoint.
for i = 1:length(spikeSampleIndices)
    voltageTrace(spikeSampleIndices(i):spikeSampleIndices(i)+(length(waveform)-1)) = waveform;  % whoa. assign the values in waveform to the spikeSampleIndices in voltageTraces.
    voltageTrace = voltageTrace(1:1000);                                                        % remove waveforms that might run off the end of the trace.
end

neuronDistance = 1;             % modifies amplitude based on distance from neuron
modifiedVoltageTrace = voltageTrace/sqrt(neuronDistance);

%% Q4. Add noise to voltageTrace
noiseAmplitude = 1;                                                 % amplitude of noise for now
noise = noiseAmplitude * pinknoise(samplingRate);           
voltageTraceNoise = modifiedVoltageTrace(:) + noise(:);             % add each element of noise to the corresponding element in voltage trace

figure
plot(voltageTraceNoise)
xlabel('Time (ms)')
ylabel('Voltage')
title('Voltage vs. Time')

%% Q5. Calculate the signal-to-noise ratio of voltageTraceNoise

signalToNoise = rms(modifiedVoltageTrace)/ rms(noise);              % RMS VoltageTrace with Distance from Electrode accounted for. 
sprintf('The Signal To Noise Ratio is: %f', signalToNoise)

%% Q6a. SNR of 5 at neuronDistance ~2.4
% a. Change neuronDistance such that SNR is approx 5. Re-run code below so we don't accidentally change noise by running code above everytime.
% Should have done this in a fn
neuronDistance = 2.4;                                               % 6a: SNR ~5.0 @ neuronDistance around 2.4
modifiedVoltageTrace = voltageTrace/sqrt(neuronDistance);
voltageTraceNoise = modifiedVoltageTrace(:) + noise(:);
signalToNoise = rms(modifiedVoltageTrace)/ rms(noise);             
sprintf('The NEW Signal To Noise Ratio is: %f', signalToNoise)

figure
subplot(1, 2, 1)
plot(voltageTraceNoise)
title(sprintf('Voltage Trace With Noise at Neuron Distance %d' , neuronDistance))
ylabel('Voltage')
xlabel('Time (ms)')

subplot(1, 2, 2)
plot(modifiedVoltageTrace)
title(sprintf('Voltage Trace Without Noise at Neuron Distance %d' , neuronDistance))
ylabel('Voltage')
xlabel('Time (ms)')

%% Q6b. SNR of ~1 at neuronDistance 60
neuronDistance = 60;                                               % 6a: SNR ~1 @ neuronDistance around 60
modifiedVoltageTrace = voltageTrace/sqrt(neuronDistance);
voltageTraceNoise = modifiedVoltageTrace(:) + noise(:);
signalToNoise = rms(modifiedVoltageTrace)/ rms(noise);             
sprintf('The NEW Signal To Noise Ratio is: %f', signalToNoise)

figure
subplot(1, 2, 1)
plot(voltageTraceNoise)
title(sprintf('Voltage Trace With Noise at Neuron Distance %d' , neuronDistance))
ylabel('Voltage')
xlabel('Time (ms)')

subplot(1, 2, 2)
plot(modifiedVoltageTrace)
title(sprintf('Voltage Trace Without Noise at Neuron Distance %d' , neuronDistance))
ylabel('Voltage')
xlabel('Time (ms)')
