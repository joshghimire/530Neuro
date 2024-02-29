%% loading data
TTrain = readtable("regression_train.csv");
% Extract features and behavior
columnsFeatures = startsWith(TTrain.Properties.VariableNames, 'channel');
columnsBehavior = startsWith(TTrain.Properties.VariableNames, 'X_');
XTrain = table2array(TTrain(:,columnsFeatures));
YTrain = table2array(TTrain(:, columnsBehavior));

TTrain1 = readtable("classification_train.csv");
% Extract directions and features
columnsFeatures = startsWith(TTrain1.Properties.VariableNames, 'channel');
XTrain1 = table2array(TTrain1(:,columnsFeatures));
YTrain1 = categorical(TTrain1.Direction);


%% 
