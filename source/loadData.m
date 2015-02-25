function data = loadData(testOrTrain)
%SAVEDATA Summary of this function goes here
%   Detailed explanation goes here

if (strcmp(testOrTrain, 'training'))
    data = load(Constants.trainingDataFileName).data;
elseif (strcmp(testOrTrain, 'testing'))
    data = load(Constants.testingDataFileName).data;
end

