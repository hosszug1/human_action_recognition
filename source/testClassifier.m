% Classify testing data.
predictedLabels = classify(testingData, testingLabels, trainingData, trainingLabels, classifMethod);

% Calculate accuracy of the process.
accuracy = 0;
for i=1:length(testingLabels)
    if (predictedLabels(i) == testingLabels(i))
        accuracy = accuracy + 1;
    end
end

accuracy = (accuracy / length(testingLabels)) * 100;

% Print out accuracy of the classifier.
fprintf('*** Total accuracy: %f ***\n', accuracy);
