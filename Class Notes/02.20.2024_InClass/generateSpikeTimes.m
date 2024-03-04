function [spikeSampleIndices] = generateSpikeTimes(timeVector, spikeRate, samplingRate)
% function generateSpikeTimes

% Generates times when spikes occur using an exponential distribution of inter-spiker intervals.

    spikeIntervals = exprnd(1/samplingRate, spikeRate,1);
    spikeSampleIndices = int32(cumsum(spikeIntervals));
end
