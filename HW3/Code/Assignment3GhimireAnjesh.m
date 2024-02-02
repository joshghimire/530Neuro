%% Q1. Load Data
load C:\Users\NaanB\Documents\Matlab\530Neuro\HW3\Data\imagingData.mat

%% Q2.
raw_dFF = data.raw_dFF;         % 2a
stimInd = data.idxCueOn;        % 2a

numStim = length(stimInd);      % 2b: number of presented stimuli
numCells = size(raw_dFF, 1);    % 2c: number of cells

timeVec = data.timeFrame*1000;  % 2d: sample times IN SECONDS

stimTimes = timeVec(data.idxCueOn);     % 2e: time IN SECONDS of each stimulus 
if stimTimes(1) > timeVec(1) && stimTimes(end) < timeVec(end)  % Confirm first and last stimuli are within timeVec
    disp("Sanity Check: First and last stimuli are within the range of timeVec!")
else
    disp("WARNING: First and last stimuli ARE NOT within the range of timeVec.")
end

% TO DO 2f.
x = (1./timeVec(2:end));                % go from sample timestamps vector to sample rate ??
frameRateinS =  % 2e: avg number of frames or samples per second.

%% Q3. 
figure  
plot(timeVec, data.raw_dFF(1, :))   % 3a: plot cont. dFF trace of first neuron
xlabel('time (S)')                  % Their magnitudes range from ~0.5 to ~6 for the tallest peaks
ylabel('dF/F')                      % They last about 0.5s - 1s
title('flurosence of neuron 1 vs. time ')

% TO DO; Did i read the instructions for this correctly?
figure
plot(timeVec, data.raw_dFF)         % 3b: plot dFF trace of all neurons
xlabel('time (S)')                          
ylabel('dF/F')                      
title('flurosence of all neurons vs. time')

%% Q4. 