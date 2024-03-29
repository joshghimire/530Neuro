function [spikeSampleIndices, spikeTimes] = generateSpikeTimes(timeVector, spikeRate, samplingRate)
% function generateSpikeTimes

% Generates times when spikes occur using an exponential distribution of inter-spiker intervals.

    spikesPerSample = spikeRate/samplingRate;                   % get the number of spikes that happen per sample
    samplesPerSpike = samplingRate/spikeRate;                   % get the number of samples per spike              
    spikeIntervals = exprnd(samplesPerSpike, spikeRate, 1);     % gets the interval between spikes
    spikeSampleIndices = int32(cumsum(spikeIntervals));         % gets the indices of each spike
    spikeSampleIndices = spikeSampleIndices(spikeSampleIndices<1000);   % remove any indices above 1000. 1000 ms is hardcoded here, but ideally pass in this value as function input 
    spikeTimes = timeVector(spikeSampleIndices);                % convert spikeSampleIndices to a vector of timestamps per spike.

end
