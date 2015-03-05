function predictNewData(newInputName, classifMethod, model, classesInUse)
%PREDICTNEWDATA Summary of this function goes here
%   Detailed explanation goes here
% Get the features from the video.

global featureMethod;

videoFeatureVector = buildFeatureVector(newInputName, featureMethod);
figure, imshow(videoFeatureVector.data);

switch classifMethod
    case ClassifierType.KNN
        prediction = predictKNN(model, videoFeatureVector);
    case ClassifierType.SVM
        testingF = standardiseData(videoFeatureVector);
        pr = zeros(1, length(classesInUse));
        for i=1:length(classesInUse)
            currentModel = model(i).model;
            [~, ~, p] = svmpredict(1, testingF, currentModel, '-b 1');
            pr(:, i) = p(:, currentModel.Label==1);
        end

        [~, prediction] = max(pr, [], 2);
    otherwise
        % Very bad.
end
prediction
fprintf('The prediction is: %s\n', classesInUse(prediction).char);

end

