%%% Main script for automatic human action recognition %%%

clear all;
close all;

% Global variables
% global trainingFiles testingFiles;

global trainingData testingData;
global trainingLabels testingLabels;
global featureMethod classifMethod;
global loadFromFile;

featureMethod = FeatureVectorType.ConvMHI;
classifMethod = ClassifierType.SVM;
loadFromFile = 1;

% Define the desired action classes to be used.
classesInUse = [ActionType.Boxing
    ActionType.Handclapping
    ActionType.Handwaving];

% Partition the files in 2 separate sets (and labels for training files).
[trainingFiles, trainingLabels, testingFiles, testingLabels] = partitionData(classesInUse);

% Create the training data or load it.
if (loadFromFile == 1)
    trainingData = loadData('training');
else
    trainingData = createFeatureData(trainingFiles);
    % Save data so we don't have to retrain the system every time.
    saveData(trainingData, 'training');
end

% Train classification method (SVM or KNN).
switch classifMethod
    case ClassifierType.KNN
        modelKNN = KNNClassifier(trainingData, trainingLabels);
    case ClassifierType.SVM
        modelKNN = KNNClassifier(trainingData, trainingLabels);
        % Create n SVMs necessary for our data and train them.
        svmArray = createSVM(trainingData, trainingLabels, classesInUse);
        
        % Create testing data so we can tune the SVM (or load it).
        if (loadFromFile == 1)
            testingData = loadData('testing');
        else
            testingData = createFeatureData(testingFiles);
            saveData(testingData, 'testing');
        end
        
        % We predict what the testing data could be and use this to tune
        % our SVMs at the same time.
        [svmArray, predictedLabels] = predictSVM(svmArray, testingData, testingLabels, classesInUse);
        
        % Calculate accuracy of the process.
        
        accuracy = 0;
        for i=1:length(testingLabels)
            if (predictedLabels(i) == testingLabels(i))
                accuracy = accuracy + 1;
            end
        end

        accuracy = (accuracy / length(testingLabels)) * 100;
        
        % accuracy = experimentSVM(trainingData, trainingLabels, testingData, testingLabels, length(classesInUse));

        % Print out accuracy of the classifier.
        fprintf('*** Total SVM classification accuracy: %f ***\n', accuracy);
        
    otherwise
        fprintf('YABAI!');
end



