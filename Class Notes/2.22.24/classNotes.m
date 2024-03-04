%% loading data
% Import the Regression TRAINING Dataset
TTrain = readtable("regression_train.csv");
% Extract features and behavior
columnsFeatures = startsWith(TTrain.Properties.VariableNames, 'channel');
columnsBehavior = startsWith(TTrain.Properties.VariableNames, 'X_');
XTrain = table2array(TTrain(:,columnsFeatures));
YTrain = table2array(TTrain(:, columnsBehavior));
xPos = YTrain(:,1);
xVel = YTrain(:,3);
yPos = YTrain(:,2);
yVel = YTrain(:,4);

%Import the Regression TESTING Dataset. This data is will be used for testing after the model is first trained. 
TTest = readtable("regression_test.csv");
columnsTestFeatures = startsWith(TTest.Properties.VariableNames, 'channel');
columnsTestBehaviors = startsWith(TTest.Properties.VariableNames, 'X_');
XTest = table2array(TTest(:,columnsTestFeatures));
YTest = table2array(TTest(:, columnsTestBehaviors));

% % Import the Classification TRAINING Dataset
% TTrain1 = readtable("classification_train.csv");
% % Extract directions and features
% columnsFeatures1 = startsWith(TTrain1.Properties.VariableNames, 'channel');
% XTrain1 = table2array(TTrain1(:,columnsFeatures1));
% YTrain1 = categorical(TTrain1.Direction);
%% Q1. Visualizing the data still
% The plots of positions and velocities resemble each other, but the velocity plots have a greater range of data along the y-axis.

figure
plot(xPos)                  % plotting just the xPosition Behavior

figure
plot(xVel)                  % plotting just the xVelocity

figure
plot(YTrain(:, 1:2))        % plotting just the x and y positions

figure
plot(YTrain(:, 3:4))        % plotting just the x and y velocities

figure
plot(YTrain)                % plotting all Positions and Velocities

figure
plot3(YTrain, xPos, yPos)   % plotting all Behaviors vs. X and Y position in a 3d plot
    
figure
plot3(xPos, yPos, xVel)     % The input arguments can be any of the positions and velocities and leads to similar looking plots.

figure 
thresholdCrossingPerTimeBin = sum(XTrain, 2);
scatter3(thresholdCrossingPerTimeBin, xPos, xVel);  % HEH? What is?
% figure
% scatter(thresholdCrossingPerTimeBin, xVel);
% figure
% scatter(thresholdCrossingPerTimeBin, yPos);
% figure
% scatter(thresholdCrossingPerTimeBin, yVel);


%% Q2. training the regression model dataset
XTrainHat = [XTrain ones(size(XTrain, 1), 1)];  % Doesn't this just add a Column vector of 1's at the end of XTrain?
YTrain = YTrain;                                % Just following/copying the example on the assignement
W = (XTrainHat' * XTrainHat) \ XTrainHat' * YTrain;

%% Q3. Test the model on the test data
XTestHat = [XTest ones(size(XTest, 1), 1)]; % First, add column of ones to X
YTest = YTest;                              % Following the example
YTestPred = XTestHat * W;                   

% Compute correlation and mean squared error
correlation = diag(corr(YTest, YTestPred));
mse = mean((YTest - YTestPred).^2, 1);

% Classify using LDA %% What to do here?
YPred = classify(XTest, XTrain, YTrain);
[C, order] = confusionmat(YTest, YPred);
figure;
cm = confusionchart(C, order);

% The confusion matrix is ONLY for the classification dataset. Just make a 2x2 subplot for 3. 
% From Johnathan about YTrain error on line 77 with classify. look for little y on the instructions for this assignment. 