function saveData(data, testOrTrain)
%SAVEDATA Summary of this function goes here
%   Detailed explanation goes here

if (strcmp(testOrTrain, 'training'))
    save(Constants.trainingDataFileName, getVariableName(data));
elseif (strcmp(testOrTrain, 'testing'))
    save(Constants.testingDataFileName, getVariableName(data));
end

