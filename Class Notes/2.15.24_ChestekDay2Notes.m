% Any periodic function can be expressed as the sum of the "weighted" sinusoids of frequencies that are integer
% ultiples of the frequency of the original function.

% bandpass filters: range of frequencies to allow through.
% frequency of spikes are around 1kHz? But hyperpolarization could be slower. And depolarization could be quicker.
% A frequently used bandpass filter for spikes could be 300Hz - 10KHZ.

% Multiunits - spike like waveforms. But can't be distinguished into multiple units. 
% Single Units - spikes from individual neurons. 

% Common Average Referencing: take mean of all signals that ou record from an array and use that as ground.
% eeg and ECOG are basically undoable without this. 

% Reference is the thing you're literally substracting from the signal. The ground is everything?

%% Feature selection: 

% Trying to select/extract every possible feature makes it more prone to overfitting.

%% Cross validation

% because datasets are probably/usually small
% Makes it painful to give up valuable data for training?

% "10 fold cross validation"
% Train on 9% of data, test on 10%
% Repeat for 10 sets of 10%
% Average the results.
    % Ex: trails 1-100
    % run 1: Train on trials 1-90, test on 90-100
    % run 2: Train on trials 1-10, 21 - 100, test on 11-20

% Single-trial cross validation.
% hold out only one trail for testing, train on everything else.
% Repeat for each trial.
    % So ex: Train on trials 1-99, test on 100?
    % Next, Train on trials 2-100, test on 1?

% First rule of macine learning: Never test on training data (except to debug or evaluate the litms of the model's ability to fit the data.)

%% Naive Bayes

% Ex: Brain controlled keyboard. N neurons firing y spikes. 

% MAXIMUM LIKELYHOOD

% p(x, y)
% x has a vector arrow
% p(x|y) 
% | means given. probability of x given y
% Probability of a certain traget x , given the probility of list of spikes?

% INDEPENDENCE ASSUMPTION
    % If neuron 1 and 2 are not independent...
    % Naive Bayes assumes that neuron 1 and 2 are independent. 


% Neurons tend to fire in a poissant distribution.
    % If they have a high fighting rate they have high variation.
    % if they have a low firing rate, they have a low variation.



% Linear Discriminant Analysis
    % highly related to Naive Bayes. 
    % choose a w matrix such that when it's multipled by data, you get the best single scalar number for differentiating between two classes.
        % only 100% correct if data is neatly separated by straight line. 

    % y(x) is your "discriminant"

    % x = data you're trying to classify.

%% Linear Regression
% More continuous? Classification is 1 vs 2. Open vs close? Vs regression is all the steps between open hand and closed hand. 

%% Modeling Assumptions

% Did she say kalmin filters? Common filters?
    % Kalman filters

% Have 2 liniear regressions:
% 1 is physics (current position is equal to last position + velocity * time)
% 2 is noisy brain data
% So you say neurons/firing rate is related to position or velocity?




