function [svmArray, pLabels] = predictSVM(svmArray, testingData, testingL, classesInUse)
%PREDICTSVM Function takes a multi-class Support Vector Machine (SVM)
%   as argument (which is only an array/vector of SVMs - 1 for each action
%   class) and returns the predicted label(s) for input data.
%
%   P = predictSVM(MODEL, TESTDATA, TESTLABELS, CLASSES) returns vector 
%   P containing 'n' number of labels where 'n' is the number of examples 
%   inputed
%
%       MODEL is an array of 'SVMClassifier' objects that have been 
%           'trained'
%       TESTDATA is a vector of 'FeatureVector' type objects
%       TESTLABELS is their corresponding labels
%       CLASSES is the vector containing 'ActionType' objects that
%           represent the action classes used by the system.
%
%   See also SVMCLASSIFIER, FEATUREVECTOR, PREDICTKNN, PREDICTNEWDATA, ACTIONTYPE. 

% This will return the data in a 'universally standard' format we keep
% throughout the system.
testingF = standardiseData(testingData);

pLabels = zeros(1, length(testingL));
        
% Necessary formatting.
testingL = transpose(testingL);

% Initialise probability estimates matrix.
pr = zeros(length(testingL), length(svmArray));
for i=1:length(svmArray)
    % Get the SVM model.
    model = svmArray(i).model;

    % Get the new predictions, accuracy and probability estimate for
    % current SVM.
    [svmArray(i).pLabels, svmArray(i).accuracy, p] = svmpredict(double(testingL==svmArray(i).classInUse),...
        testingF, model, '-b 1');
    % Add the probability estimate to the matrix.
    pr(:, i) = p(:, model.Label==1);

end % for

% Based on the probability estimates, decide on the predicted label.
[~, pLabels] = max(pr, [], 2);

end % function predictSVM

