function saveData(data, testOrTrain)
%SAVEDATA Function used to save training/testing data to matlab
%   '.m' files.
%
%   saveData(D, TYPE) saves the data stored in D
%
%       D is the variable/data to be stored
%       TYPE is the type of the data: training or testing
%
%   See also LOADDATA.

% The name of the training and testing files are saved in the
% constants/parameter class. Save accordingly.
if (strcmp(testOrTrain, 'training'))
    save(Constants.trainingDataFileName, getVariableName(data));
elseif (strcmp(testOrTrain, 'testing'))
    save(Constants.testingDataFileName, getVariableName(data));
else
    % Throw exception.
    error('The supplied argument is neither "testing" nor "training"!');
end % if

end % function saveData