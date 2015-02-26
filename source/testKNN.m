% Create testing data for KNN.
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