function predictNewData(newInputName, classifMethod, model)
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
        prediction = predictSVM();
    otherwise
        % Very bad.
        prediction = 0;
end

fprintf('The prediction is: %d\n', prediction);

end

