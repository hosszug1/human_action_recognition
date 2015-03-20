function data = loadData(testOrTrain)
%SAVEDATA Summary of this function goes here
%   Detailed explanation goes here

if (strcmp(testOrTrain, 'training'))
    data = load(Constants.trainingDataFileName);
    data = data.data;
elseif (strcmp(testOrTrain, 'testing'))
    data = load(Constants.testingDataFileName);
    data = data.data;
else
    % Throw exception.
end

end

