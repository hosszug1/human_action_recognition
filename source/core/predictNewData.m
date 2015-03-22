function predictNewData(newInputName, classifMethod, model, classesInUse)
%PREDICTNEWDATA Function predicts new data supplied, according to the run
%   parameters of the system and prints it.
%
%   predictNewData(INPUT, C_METHOD, MODEL, CLASSES) will print out the new
%   prediction of INPUT
%
%       INPUT is the name of the new video file
%       C_METHOD is the classification method being used (KNN or SVM)
%       MODEL is the corresponding classifier model (KNN or SVM)
%       CLASSES is a vector containing 'ActionType' objects representing
%           the action classes currently used by the system.
%
%   See also PREDICTKNN, PREDICTSVM, ACTIONTYPE.

% We need to know the feature type.
global featureMethod;

% Build a new feature vector for the input video file.
videoFeatureVector = buildFeatureVector(newInputName, featureMethod);

% Based on the classification method, get the prediction either from a
% KNN classifier or a Support Vector Machine (SVM).
switch classifMethod
    case ClassifierType.KNN
        prediction = predictKNN(model, videoFeatureVector);
    case ClassifierType.SVM
        % Standardise the data first.
        testingF = standardiseData(videoFeatureVector);
        % Initialise probabilities vector.
        pr = zeros(1, length(classesInUse));
        
        % For each class, get the prediction from the corresponding SVM
        % AND the probability estimate of the SVM (how 'sure' the SVM is
        % of its decision).
        for i=1:length(classesInUse)
            currentModel = model(i).model;
            [~, ~, p] = svmpredict(1, testingF, currentModel, '-b 1 -q');
            pr(:, i) = p(:, currentModel.Label==1);
        end % for
        % Based on the probability estimates, check which is the highest
        % one, take that as the prediction.
        [~, prediction] = max(pr, [], 2);
    otherwise
        error('Invalid classification method supplied!');
end % switch

% What we have so far is the index, get the correct class that has been
% predicted from the vector of action classes.
prediction = classesInUse(prediction);
fprintf('The prediction is: %s\n', prediction.char);

end % function predictNewData

