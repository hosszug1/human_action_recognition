function svmArray = createSVM(trainingData, trainingL, classesInUse)
%CREATESVM Function for creating a multi-class SVM.
%   
%   SA = createSVM(DATA, LABELS, CLASSES) returns a vector containing
%   multiple SVMs based on the '1 vs all' method.
%
%       DATA is the vector of 'FeatureVector' type objects representing the
%           data to be used for training the SVMs
%       LABELS is the vector of the corresponding labels
%       CLASSES is a vector of 'ActionType' classes representing how many
%           classes are in the data and, therefore, how many SVMs will be
%           needed.
%
%   See also FEATUREVECTOR, FEATUREVECTORTYPE, ACTIONTYPE.

% This will return the data in a 'universally standard' format we keep
% throughout the system.
trainingF = standardiseData(trainingData);

% Necessary formatting.
trainingL = transpose(trainingL);
svmArray = [];

for i=1:length(classesInUse)
    % Create a new SVM object.
    newSVM = SVMClassifier(i, classesInUse(i));

    % Create a new SVM model that will be trained for the class currently
    % in use.
    newSVM.model = svmtrain(double(trainingL==newSVM.classInUse), trainingF, '-t 1 -b 1');
    % Initialise accuracy with 0
    newSVM.accuracy = 0;

    svmArray = [svmArray; newSVM];
end % for

end % function createSVM

