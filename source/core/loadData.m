function data = loadData(testOrTrain)
%LOADDATA Function used to load training/testing data from existing
%   '.m' files.
%
%   D = loadData(TYPE) returns the data stored in files into D
%
%       TYPE is the type of the returned data: training or testing
%
%   See also SAVEDATA.

% The name of the training and testing files are saved in the
% constants/parameter class. Load accordingly.
if (strcmp(testOrTrain, 'training'))
    data = load(Constants.trainingDataFileName);
    data = data.data;
elseif (strcmp(testOrTrain, 'testing'))
    data = load(Constants.testingDataFileName);
    data = data.data;
else
    % Throw exception.
    error('The supplied argument is neither "testing" nor "training"!');
end % if

end % function loadData

