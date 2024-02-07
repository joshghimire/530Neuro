% dF/F (fluoresence data). Neurons in the bottom have a larger change (systematic issue). 
    % Afew pre-processing steps such as suite2p which do motion correction and soma detection. 

% Plotting a little before the signal in a PSTH tells us a little but abot the baseline activity.

% PSTH reveals systematic response to a stimulus. If a neuron fires before stimlus or after, as you avg all neurons together, 
% PSTH will be more flat. 
% 1) Know what the kinetics/timescales of a typical transient? 1-25 secs. Don't go shorter than that. 
% You want the windows to be smaller than the smallest interstimulus interval. This way, you know you're not going to include responses from other
% stimuli. 

% Average of windows for all spikes for one neuron is the PSTH for that neuron. 

%% Gideon notes:
minISI = min(diff(timeVec(stimInd)))
% choosing 5s
% convert tonumsamples
windowSizeInSamples=floor(frameRateInS*5);

% Lmao Hazel thinks I'm going to take acceptable notes. 

response = currCellDFF(stimInd(i)-windowSizeInSamples:stimInd(i)+windowSizeInSamples)
% looks like this [ | ]
% where [ is start of the windowSizeInSamples, | is the stimulus, ] is the end of the windowSizeInSamples

% To test for significance, take some period after stimulus and compare it to some other period. 
% do a paired test (paired t-test, ttest commad in MtLB) to compare response to baseline. Because if it's not paired, the response can't be compared?