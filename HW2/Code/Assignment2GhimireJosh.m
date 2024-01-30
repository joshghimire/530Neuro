%% Q1.
%Generate 3 vectors
vector1 = 1:100;
vector2 = 1:1000;
vector3 = ceil(rand(1,100)*10);

% find indices where vector is b/t 5 and 10 (inclusive) or greater than 20
v1Indices = find(vector1>=5 & vector1<=10 | vector1 >20);   
v2Indices = find(vector2>=5 & vector2<=10 | vector2 >20);   
v3Indices = find(vector3>=5 & vector3<=10 | vector3 >20);   
%% Q2. 
x = 10:20;
y = 10*(ones(1,11));
figure
plot(x,y)
xlim([0, 30]);
ylim([0,30]);
hold on

x2 = 10:20;
y2 = 20*(ones(1,11));
plot(x2,y2);

x3 = 10*(ones(1,11));
y3 = 10:20;
plot(x3, y3);

x4 = 20*(ones(1,11));
y4 = 10:20;
plot(x4,y4);
title('Behold the Square')

%% Q3.
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

%% Q4. 
V1 = normrnd(10, 1, 1, 10000);
V2 = normrnd(12, 2, 1, 10000);
binCenters = 0:0.5:20;

figure
histogram(V1, binCenters)
hold on
histogram(V2, binCenters)

xlabel('Overwatch Rank')
ylabel('Cortisol Level')
title('Stress Levels vs. Overwatch Rank')

%% Q5. 
figure
plotMyLine(1,2,'red')

%% Q6. 
figure
hold on
for i = -100:100
    plotMyLine(i, 2, 'red')
end

%% Q7. TODO
vector1 = 1:100;
vector2 = 1:1000;
vector3 = ceil(rand(1,100)*10);

getIndicesOfDivisibleBy7(vector1)
getIndicesOfDivisibleBy7(vector2)
getIndicesOfDivisibleBy7(vector3)

%% Q8.
vector1 = 1:100;
vector2 = 1:1000;
vector3 = ceil(rand(1,100)*10);

getThirdLargestValue(vector1)
getThirdLargestValue(vector2)
getThirdLargestValue(vector3)