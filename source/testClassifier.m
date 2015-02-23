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
