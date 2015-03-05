function svmArray = createSVM(trainingData, trainingL, classesInUse)
%CLASSIFY 

% This will return the data in a 'universally standard' format we keep
% throughout the system.
trainingF = standardiseData(trainingData);

% Need to create as many SVMs as the number of classes we have.

% Necessary formatting.
trainingL = transpose(trainingL);
svmArray = [];

for i=1:length(classesInUse)
    % Create a new SVM object.
    newSVM = SVMClassifier(i, classesInUse(i));
    % See which are the classes not used.
    % classesNotUsed = setdiff(classesInUse, newSVM.classInUse);            

    % Change training and testing data to suit the binary SVM.
    % binaryTrainingL = changem(trainingL, [-1 -1], classesNotUsed);
    % binaryTrainingL = changem(binaryTrainingL, 1, newSVM.classInUse);

    newSVM.model = svmtrain(double(trainingL==newSVM.classInUse), trainingF, '-t 1 -b 1');
    % Initialise accuracy with 0
    newSVM.accuracy = 0;

    svmArray = [svmArray; newSVM];
end

end

