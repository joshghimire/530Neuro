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
Vaverages = [V1average V2average V3average]
myAverages1 = mean(Vaverages)

%% Question 5
combinedVectors = [V1 V2 V3]
myAverages2 = mean(combinedVectors)

%% Question 6 
% myAverages1 equals myAverages2. When there are separate vectors of the same size,
% the average of the means of each vector is the same as the mean of the separate vectors combined. 

%% Question 7 
meanCeilV1 = mean(ceil(V1))
meanV1 = mean(V1)
mean(ceil(V1)) == mean(V1)
% A.
% Yes, mean(ceil(V1)) equals mean(V1). The ceil function rounds to the nearest integer in the direction of positive infinity.
% As V1 is a vector of integers already, the ceil function does not change this vector so the mean(ceil(V1)) is the same as mean(V1).

meanCeilV2 = mean(ceil(V2))
meanV2 = mean(V2)
mean(ceil(V2)) == mean(V2)
% B. 
% Mean(ceil(V2)) does NOT equal mean(V2). As V2 is a vector of floats, the ceil function rounds each number in the vector up to the nearest integer. 
% As ceil(V2) is a different array than V2, mean(ceil(V2)) is also a different value than mean(V2).

%% Question 8 
% A. 
% Calculate meanCeilV1 again
ceilV1 = ceil(V1);
meanCeilV1 = mean(ceilV1)

%Calculate ceilMeanV1
meanV1 = mean(V1);
ceilMeanV1 = ceil(meanV1)

% Check if mean of ceilV1 is equal to ceil of meanV1
meanCeilV1 == ceilMeanV1

% B.
% ceil(mean(V1)) will take the mean of V1, which is 50.5 and round it up to 51 with ceil.
% mean(ceil(V1)) will try to round up all elements in V1 to the nearest positive integer. 
% As V1 is already a vector of integers, V1 will not be altered, and the mean, which is 50.5, is calculated.  

%% Question 9
v3SelectedAverage = mean(V3(10:20))

%% Question 10
% Create vectors of various sizes:
vector1 = rand(1,10);
vector2 = rand(1,1000);
vector3 = rand(1,1000000);

% Calculate Standard error of the mean for each vector
vector1Sem = std(vector1) / sqrt(length(vector1))
vector2Sem = std(vector2) / sqrt(length(vector2))
vector3Sem = std(vector3) / sqrt(length(vector3))

% The values are not similar. The standard error of the mean decreases as number of samples or vector length increases. 
% As the standard error is a measure for how accurately a sample data represents population data, as the number of samples increases,
% the standard error decreases since the standard error is approaching the true value of the population data. 

%% Bonus Question
recordingFrequency = 5000;     %acquisition frequency in Hz
timeMins = 10;                 %acquisition time in minutes
timeSeconds = timeMins * 60;   %acquisition time in seconds
timePerSample = 1/recordingFrequency;                                       %how long it takes (in seconds) to collect a sample
arraySecondsSinceRecordingStart = 0:timePerSample:timeSeconds;              %vector whose value in every cell is the amount of seconds passed since beginning of recording.
arraySecondsSinceRecordingStart = arraySecondsSinceRecordingStart(2:end);   %remove time 0 




