%%% Training script for automatic human action recognition %%%

% Clear workspace and close all windows.
clear all;
close all;

% Reset timer counter (used to count various operations throughout the
% process).
tic;

% Global variables.
global trainingData testingData;
global trainingLabels testingLabels;
global featureMethod classifMethod;
global loadFromFile;

featureMethod = FeatureVectorType.ConvMHI;
classifMethod = ClassifierType.SVM;
% Flag to specify if data should be loaded from file or created.
loadFromFile = 1;

% Define the desired action classes to be used.
classesInUse = [ActionType.Boxing
    ActionType.Handclapping
    ActionType.Handwaving];

% Partition the files in 2 separate sets and labels accordingly.
[trainingFiles, trainingLabels, testingFiles, testingLabels] = partitionData(classesInUse);

% Create the training data or load it.
if (loadFromFile == 1)
    trainingData = loadData('training');
else
    trainingData = createFeatureData(trainingFiles);
    % Save data so we don't have to retrain the system every time.
    saveData(trainingData, 'training');
end % if

% Check how much time has passed for training and reset the counter.
timeSpentTraining = toc;
tic

% Based on what classifier is used (SVM or KNN), "train" said classifier.
switch classifMethod
    case ClassifierType.KNN
        % If it's a KNN, all that needs to be done is to create a model of
        % the training data.
        modelKNN = KNNClassifier(trainingData, trainingLabels);
    case ClassifierType.SVM
        % If it's an SVM, we have to create 'n' binary SVMs based on how
        % many action classes are used.
        svmArray = createSVM(trainingData, trainingLabels, classesInUse);
        
        % Create testing data so we can tune the SVM (or load existing
        % one).
        if (loadFromFile == 1)
            testingData = loadData('testing');
        else
            testingData = createFeatureData(testingFiles);
            saveData(testingData, 'testing');
        end % if
        
        % We use the testing data to tune the SVMs and check their accuracy
        % in the process.
        [svmArray, predictedLabels] = predictSVM(svmArray, testingData, testingLabels, classesInUse);
        
        % Calculate the overall accuracy of the SVMs.
        accuracy = 0;
        for i=1:length(testingLabels)
            if (predictedLabels(i) == testingLabels(i))
                accuracy = accuracy + 1;
            end % if
        end % for

        accuracy = (accuracy / length(testingLabels)) * 100;

        % Print out accuracy of the classifier.
        fprintf('*** Total SVM classification accuracy: %f ***\n', accuracy);
        
    otherwise
        error('Invalid classifier selected!');
end % switch

% Get the timer counter that now represents how much time was spent on
% setting up the SVMs/KNNs and testing (testing in this context meants
% using the test-data for fine-tuning the SVM; for KNN the test data is not
% used here).
timeSpentTesting = toc;

