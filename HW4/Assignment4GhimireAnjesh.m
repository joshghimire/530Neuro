%% Load data
%load C:\Users\NaanB\Documents\Matlab\530Neuro\HW3\Data\imagingData.mat
load imagingData.mat
load stimType.mat   % for Q.6

% Load Variables
raw_dFF = data.raw_dFF;         % 2a
stimInd = data.idxCueOn;        % 2a: sample number of each presented stimulus

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
        currResp = currCellDFF(stimInd(j) - windowSizeInFrames : stimInd(j) + windowSizeInFrames - 1); % instructions say windowSizeInFrames * 2 + 1, but doesn't that make an uneven vector? Paired T-test of [windowSize:stimulus(exclusive)) vs. [stimulus(inclusive):windowsize] won't work with + 1 ?? 
        currCellResp(j,:) = currResp;
    end
    allCellRasters{i} = currCellResp;
end
%% Q2.
xAxis = 1:windowSizeInTime;
yAxis = 1:numStim;
for i = 1:5 %length(allCellRasters)  % FOR JONATHAN, capped at 5. To see all neurons, remove number and uncomment %length 
    figure
    subplot(2,1,1)
    imagesc(xAxis, yAxis, allCellRasters{i})     % use imagesc x, y syntax. THANKS JOHNATHAN
    title(sprintf('Neuron %d Responses', i))
    ylabel('Trial-wise Responses')
    xlabel('Time (s)')

    subplot(2,1,2)
    x = linspace(1,windowSizeInTime, length(allCellRasters{i}));    % JESUS. The easiest way to match x-axes for both subplots is to use linspace to make x-axis for plot fn.
    plot(x, mean(allCellRasters{i}))
    xlabel('Time (s)')
    ylabel('Mean PSTH') 
end
%% Q3. Using a function to derive a Neuron's DFF raster
% currDFFRaster = deriveDFFraster(currCellDFF, stimInd, windowSizeInFrames);
for i = 1:numCells
    currCellDFF = raw_dFF(i, :);
    allCellRasters{i} = deriveDFFraster(currCellDFF, stimInd, windowSizeInFrames);    % calculate the DFF raster for the i-th neuron, and save it in allCellRastersFn{i}
end
%% Q4. Determine statistical significance of responsiveness of a given neurons dFF raster
for i = 1:numCells
    currCellDFF = allCellRasters{i};
    isResponsive(i) = testSoundResponsiveness(currCellDFF,windowSizeInFrames);
end    
%% Q5. 
responsiveCells = isResponsive;
responsiveRate = (sum(isResponsive))/length(isResponsive);          % 5a. 
sprintf("%d/%d cells are responsive to the sound stimulus!", sum(isResponsive), length(isResponsive))

% The test outcome easily captures sound responsiveness to cells that have a very strong or clear response to the stimulus (such as neuron 4).
% The test outcome also captures the non-responding cells which do not respond to a sound stimulus (such as neuron 10) very well.
% The test outcome does not capture sound responsiveness of 'messy' neurons which might be randomly firing before the stimulus, but have a clear but
% delayed and weak or inconsistent response to the sound stimulus (such as neuron 7). There is a clear alignment of firing for this neuron as seen on the raster plot
% that is not captured by the t-test.  

%% Q6. Using stimType.mat
% 6a.
%xAxis = linspace(1,windowSizeInTime, length(allCellRasters{i}));
xAxis = linspace(-4,4,74);
yAxis = 1:numStim;
for i = 1:5 %length(allCellRasters)  % FOR JONATHAN, capped at 5. To see all neurons, remove number and uncomment %length 
    figure
    hold on
    title(sprintf('Cell #%d Responsive=%d', i, responsiveCells(i)))
    ylabel('Stimulus number')
    xlabel('Time (s)')
    for j = 1:numStim
        if stimType(j) == 1
            color = 'b';
        elseif stimType(j) == 2
            color = 'r';
        elseif stimType(j) == 3
            color = 'g';
        elseif stimType(j) == 4
            color = 'k';
        end

        plot(xAxis, allCellRasters{i}(j, :), color)
        
    end
end    

% 6b.
% Neuron 29 responds robustly to all of the different stimuli.
% Neuron 33 consistently responds strongly to stimulus 4. Interestingly, it seems to consistently respond weakly to stimulus 3 (weak compared to stimulus 4), and does so slightly earlier than the other stimuli. 
% Neuron 9 consistently has large responses to all stimuli (though, neuron 9 also seems to respond the least robustly to stimulus 1)
% Neuron 8 shows consistent differences in the timing and intensities of stimuli. Neuron 8 consistently fires faster for stimulus 2 and consistently fires slower for stimulus 3. It also has the strongest, yet 'middle speed' response to stimulus 1. 
