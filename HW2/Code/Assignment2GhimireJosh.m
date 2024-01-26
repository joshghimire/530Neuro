%% Q1.
vector1 = 1:100;
vector2 = 1:1000;
vector3 = ceil(rand(1,100)*10);

%% Q2. 
x = [1:30;]
figure;
plot

%% Q3
lengthOfVector = 100000;
V1 = randn(1, lengthOfVector);
recordingFreq = 5000;               % recording freq in Hz
timePerSample = 1/5000;             % time it takes to record each sample
lengthOfRecording = lengthOfVector/recordingFreq;     % total length of recording in seconds
xAxis = 0:timePerSample:lengthOfRecording;            % make the x axis for plot in seconds
xAxis = xAxis(2:end);                                 % remove index 1, aka time t=0

figure
plot(xAxis, V1)
xlabel('Time (sec)')
ylabel('Voltage')
title('Voltage vs. Time')
