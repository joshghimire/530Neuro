%% Load data
load C:\Users\NaanB\Documents\Matlab\530Neuro\HW3\Data\imagingData.mat
% load 'H:\My Documents\MATLAB\530Neuro\HW3\Data\imagingData.mat'

% Load Variables
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
           
for i = 1:length(timeVec)               % 2f
    timeVecDiff = diff(timeVec);        % get the difference between each element in timeVec to calculate mean sample rate
end
meanSampleRate = mean(timeVecDiff);
meanFramesPerSecond = 1/meanSampleRate;

%% Q1. 
% convert timestamps of stimuli to frames in the video. Since it will be an imperfect conversion, use floor to round down to the closest integer.
for i = 1:length(stimInd)
    stimInFrames(i) = floor(stimInd(i)*meanFramesPerSecond);   
end

% get the window size to use for each neuron. The window size for each neuron will be the smallest inter stimulus interval.
windowSizeInTime = min(floor(diff(stimTimes)));                         % The smallest period between stimuli in seconds
windowSizeInFrames = ceil(windowSizeInTime * meanFramesPerSecond);      % 1/2 the window size in frames

allCellRasters = {};
for i= 1:numCells
    currCellDFF = raw_dFF(i, :);
    currCellResp = [];
    for j = 1:numStim   % get sound triggered dff for 1 neuron
        currResp = currCellDFF(stimInd(j) - windowSizeInFrames : stimInd(j) + windowSizeInFrames);
        currCellResp(j,:) = currResp;
    end
    allCellRasters{i} = currCellResp;
end
%% Q2.
xAxis = 1:windowSizeInTime;
yAxis = 1:numStim;
for i = 1:2 %length(allCellRasters)         % TODO remove number and uncomment %length 
    figure
    subplot(2,1,1)
    imagesc(xAxis, yAxis, allCellRasters{i})     % use imagesc x, y syntax. THANKS JOHNATHAN
    title(sprintf('Neuron %d Responses', i))
    ylabel('Trial-wise Responses')
    xlabel('Time (s)')
   
    x= 1:1:5;
    subplot(2,1,2)
    plot(x, mean(allCellRasters{i}))
    xlabel('Time (s)')
    ylabel('Mean PSTH')
    % xlim([1, 5]);
    % xticks(1:meanFramesPerSecond:75)
    % xticks(1:floor(meanFramesPerSecond):size(allCellRasters{i}, 2)); DIdn't work
end
