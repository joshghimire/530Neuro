function [currDFFraster] = deriveDFFraster(currCellDFF, stimInd, windowSizeInFrames)
% function deriveDFFraster. Generates the DFF raster for each neuron 
    numStim = length(stimInd);
    for j = 1:numStim   
        currResp = currCellDFF(stimInd(j) - windowSizeInFrames : stimInd(j) + windowSizeInFrames - 1);
        currDFFraster(j,:) = currResp;
    end
end