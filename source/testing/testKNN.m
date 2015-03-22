%TESTKNN
%   Create testing data for a KNN classifier and test the accuracy of it.
%   IMPORTANT! This script can only be used in conjunction with the
%   'trainSystem' script with specific parameters right now (will be
%   improved).
%
%   See also TRAINSYSTEM, KNNCLASSIFIER, CREATEKNN, PREDICTKNN

% Load the test data from file or create it (and save it for later use).
if (loadFromFile == 1)
    testingData = loadData('testing');
else
    testingData = createFeatureData(testingFiles);
    saveData(testingData, 'testing');
end
predictedLabels = predictKNN(modelKNN, testingData);

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
fprintf('*** Total KNN classification accuracy: %f ***\n', accuracy);