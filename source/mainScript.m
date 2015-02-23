%%% Main script for automatic human action recognition %%%

clear all;
close all;

%%% Global parameters for the script.
featureMethod = FeatureVectorType.MHI;
classifMethod = ClassifierType.KNN;

% Define the desired action classes to be used.
classesInUse = [ActionType.Boxing
    ActionType.Handclapping
    ActionType.Handwaving];

% Partition the files in 2 separate sets (and labels for training files).
[trainingFiles, trainingLabels, testingFiles, testingLabels] = partitionData(classesInUse);

tic;
% Create the training data.
trainingData = createFeatureData(trainingFiles, featureMethod);
timeSpentTraining = toc;

% Train classification method (SVM or KNN).

tic;
% Create testing data.
testingData = createFeatureData(testingFiles, featureMethod);
timeSpentTesting = toc;

% error('Stop');

% Classify testing data.
predictedLabels = classify(testingData, testingLabels, trainingData, trainingLabels, classifMethod, classesInUse);

% Calculate accuracy of the process.
accuracy = 0;
for i=1:length(testingLabels)
    if (predictedLabels(i) == testingLabels(i))
        accuracy = accuracy + 1;
    end
end

accuracy = (accuracy / length(testingLabels)) * 100;
% accuracy = checkAccuracy(accuracy);

% Print out accuracy of the classifier.
fprintf('*** Total accuracy: %f ***\n', accuracy);

