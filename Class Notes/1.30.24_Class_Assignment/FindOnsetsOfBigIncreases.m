%% Using findchangepts functionf

clear
v=randn(1,10000);
v([220:280,1520:1580,5521:5644,8521:8644])=v([220:280,1520:1580,5521:5644,8521:8644])+10;
threshold = mean(v) + 2.5*std(v);  
% this threshold is used often for detecting sharpwaveripples. 

tic
indexes = findchangepts(v, 'Statistic', 'linear', 'MinThreshold', 50);      % find where vector v has a slope above 50
indexes(1:2:end);                                                           % since upswing and downswing have same slope and downswing indices are upswing indicies +1, only use upswing indices
toc

%% Script for function call
clear
v=randn(1,10000);
v([220:280,1520:1580,5521:5644,8521:8644])=v([220:280,1520:1580,5521:5644,8521:8644])+10;
  
tic
indicesBeyondThreshold = findOnsetsOfBigIncreases(v)
toc

%% parfor loop 
% DOESNT WORK CANT GO FAST

%% Re-do with smoothed data:

vsmooth = smooth(v, 20);

% gaussian smoothing is a thing too. Gives a larger weight to points around where you want to smooth. 

%% Double-thresholds
%sometimes you can use a first threshold to find when the signal goes high. Then look for asecond threshold that's smaller.
    %if the first threshold was mean + 5 standard deviation, second threshold could be mean + 1 std.


%% function definition

function [indicesBeyondThreshold] = findOnsetsOfBigIncreases(v)
% findOnsetofBigIncreases 
% Detects the onsets of increases in signal above threshold
%
% INPUT 
% v         a vector of timeseries data
%
% OUTPUT
% indicesBeyondThreshold
%   indexes of vector v which are the points at which are the initial
%   points where the signal increases above threshold
threshold = mean(v) + 2.5*std(v);                     
    for i = 2:length(v)                               % this will miss an onset if it occurs at index 1 of v
        if v(i-1) <= threshold && v(i) > threshold    % label an element in vectorV as an onset if ith index of V is above threshold AND i-1 index of V is at or below threshold.
            onsetIndices(i) = v(i);                   % will not produce a vector as long as vectorv. Only a vector as long as the index of the last onset.
            indicesBeyondThreshold = find(onsetIndices ~= 0);
        else        
        end
    end  
end
