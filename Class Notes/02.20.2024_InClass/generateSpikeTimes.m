function [spikeSampleIndices] = generateSpikeTimes(timeVector, spikeRate, samplingRate)
    spikeIntervals = exprnd(1/samplingRate, spikeRate,1);
    spikeSampleIndices = int32(cumsum(spikeIntervals));
end
