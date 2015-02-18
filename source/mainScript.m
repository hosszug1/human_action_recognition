%%% Main script for automatic human action recognition %%%

clear all;
close all;

% Define the desired action classes to be used.
classesInUse = [ActionType.Boxing
    ActionType.Handclapping
    ActionType.Handwaving];

% Partition the files in 2 separate sets (and labels for training files).
[trainingFiles, trainingLabels, testingFiles, testingLabels] = partitionData(classesInUse);

tic;
% Create the training data.
trainingData = createFeatureData(trainingFiles);
timeSpentTraining = toc;

tic;
% Create testing data.
testingData = createFeatureData(testingFiles);
timeSpentTesting = toc;

% Classify testing data.
predictedLabels = classify(testingData, trainingData, trainingLabels, 0);

% Calculate accuracy of the process.
accuracy = 0;
for i=1:length(testingLabels)
    if (predictedLabels(i) == testingLabels(i))
        accuracy = accuracy + 1;
    end
end

accuracy = (accuracy / testingLabels) * 100;

% Print out accuracy of the classifier.
fprintf('*** Total accuracy: %f ***\n', accuracy);





