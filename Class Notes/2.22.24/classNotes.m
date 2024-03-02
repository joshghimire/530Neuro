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
thresholdCrossingPerTimeBin = sum(XTrain, 2);
figure
plot3(xPos, yPos, xVel) % The input arguments can be any of the positions and velocities and leads to similar looking plots.
figure 
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
YTest = YTest;                              % Following the exmple
YTestPred = XTestHat * W;                   

% Compute correlation and mean squared error
correlation = diag(corr(YTest, YTestPred));
mse = mean((YTest - YTestPred).^2, 1);

% Classify using LDA %% What to do here?
YPred = classify(XTest, XTrain, YTrain);
[C, order] = confusionmat(YTest, YPred);
figure;
cm = confusionchart(C, order);