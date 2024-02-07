%% Q1. Load Data
load C:\Users\NaanB\Documents\Matlab\530Neuro\HW3\Data\imagingData.mat
% load 'H:\My Documents\MATLAB\530Neuro\HW3\Data\imagingData.mat'

%% Q2.
raw_dFF = data.raw_dFF;         % 2a
stimInd = data.idxCueOn;        % 2a

numStim = length(stimInd);      % 2b: number of presented stimuli
numCells = size(raw_dFF, 1);    % 2c: number of cells

timeVec = data.timeFrame./1000;  % 2d: sample times IN SECONDS

stimTimes = timeVec(data.idxCueOn);     % 2e: time IN SECONDS of each stimulus 
if stimTimes(1) > timeVec(1) && stimTimes(end) < timeVec(end)  % Confirm first and last stimuli are within timeVec
    disp("Sanity Check: First and last stimuli are within the range of timeVec!")
else
    disp("WARNING: First and last stimuli ARE NOT within the range of timeVec.")
end

timeVecDiff = zeros(size(timeVec, 1), 1);           % 2f: pre-allocate vector for a for-loop
for i = 2:length(timeVec)                           % 2f: skip first index of timeVec 
    timeVecDiff(i, 1) = timeVec(i) - timeVec(i-1);  % get the difference between each element in timeVec to calculate mean sample rate
end
meanSampleRate = mean(timeVecDiff);
meanFramesPerSecond = 1/meanSampleRate;

%% Q3. 
figure  
plot(timeVec, data.raw_dFF(1, :))   % 3a: plot cont. dFF trace of first neuron
xlabel('time (S)')                  % Their magnitudes range from ~0.5 to ~6 for the tallest peaks
ylabel('dF/F')                      % They last about 0.5s - 1s
title('flurosence of neuron 1 vs. time')
 
for i = 1:size(data.raw_dFF,1)      % 3b: plot continuous dFF traces for all neurons.
    rawDFFPlusI(i, :) = data.raw_dFF(i, 1:end) + i; % add the value of i the trace of the ith neuron, for all neurons
end
figure
plot(timeVec, rawDFFPlusI) 
xlabel('time (S)')                          
ylabel('Neuron')                      
title('flurosence of all neurons vs. time')
ylim([0 48])
%% Q4.
hold on
for i = 1:numStim % use 'line' with for loop instead of 'x-line'to determine the height of each x-line.
    line([stimTimes(i) stimTimes(i)], [0 numCells + 1], 'Color','k','Linestyle','--');  % I think one stimTime(i) is the x coordinate on the bottom of the plot, other is on top of plot.
end

%% Q5. 
% 1) Some neurons, like Neuron 28 don't react at all to stimulus.
% 2) Some neurons, like neurons 2 and 29 fire readily and consistently every time the stimulus is applied.
% 3) Some neurons, like neuron 3 fire after the stimulus some of the time. And their firing isn't consistent. 
%    Sometimes there is a large change in flurosence when they fire, other times the change is tiny. 
% 4) Some neurons, like neuron 14 have a 'noisy' signal throughout the recording. 
% 5) Of the neurons in the dataset, most don't consistently fire with the stimulus. There are more neurons that don't
%    fire after the stimulus or fire infrequently after the stimulus than there are neurons which fire consistently after
%    the stimulus. 

%% Q7 IN CLASS PSTH for neuron 1
for i = 1:length(stimTimes)
    psth(i) = 
