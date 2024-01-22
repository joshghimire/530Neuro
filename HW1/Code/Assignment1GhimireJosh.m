%% Question 1
ceil(1.455)          %1a
6^3                  %1b
log(exp(3))          %1c
round(7.8123, 2)     %1d

%% Question 2
V1 = [1:1:100]       %2i
V2 = [0.5:1:100]     %2ii
V3 = [0.1:0.1:10]    %2iii

%% Question 3
V1average = mean(V1)
V2average = mean(V2)
V3average = mean(V3)

%% Question 4
Vaverages = [V1 V2 V3]
myAverages1 = mean(Vaverages)

%% Question 5
combinedVectors = [V1 V2 V3]
myAverages2 = mean(combinedVectors)

%% Question 6 TODO
% myAverages1 equals myAverages2. 

%% Question 7 TODO


%% Question 8 TODO


%% Question 9
v3SelectedAverage = mean(V3(10:20))

%% Question 10

%% Bonus Question
recordingFrequency = 5000;     %acquisition frequency in Hz
timeMins = 10;                 %acquisition time in minutes
timeSeconds = timeMins * 60;   %acquisition time in seconds
timePerSample = 1/recordingFrequency;                                       %how long it takes (in seconds) to collect a sample
arraySecondsSinceRecordingStart = 0:timePerSample:timeSeconds;              %vector whose value in every cell is the amount of seconds passed since beginning of recording.
arraySecondsSinceRecordingStart = arraySecondsSinceRecordingStart(2:end);   %remove time 0 




