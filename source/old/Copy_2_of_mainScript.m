%%% Main script for automatic human action recognition

% Global sort of parameters. Change to tweak testing script.
% Folder for getting videos.
INPUT_FOLDER = 'human_action_recognition\data\';
BOXING = 1;
HANDCLAPPING = 2;
HANDWAVING = 3;
JOGGING = 4;
RUNNING = 5;
WALKING = 6;

% Get each subfolder (will represent a class each).

boxingFiles = dir(strcat(INPUT_FOLDER, 'boxing'));
handclappingFiles = dir(strcat(INPUT_FOLDER, 'handclapping'));
handwavingFiles = dir(strcat(INPUT_FOLDER, 'handwaving'));

% Get rid of "." and ".." elements.
boxingFiles = boxingFiles(3:end);
handclappingFiles = handclappingFiles(3:end);
handwavingFiles = handwavingFiles(3:end);

% Split KTH dataset to training and testing data.
boxingTrainingFiles = boxingFiles(1:(end/2));
handclappingTrainingFiles = handclappingFiles(1:(end/2));
handwavingTrainingFiles = handwavingFiles(1:(end/2));
boxingTestingFiles = boxingFiles((end/2+1):end);
handclappingTestingFiles = handclappingFiles((end/2+1):end);
handwavingTestingFiles = handwavingFiles((end/2+1):end);

% Create feature vector sets for each set of data.
[boxingData, boxingMHIs,  = createFeatureData(boxingFiles);
[handclappingData = createFeatureData(handclappingFiles);
[handwavingData = createFeatureData(handwavingFiles);