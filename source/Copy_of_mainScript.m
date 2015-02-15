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

% Step 1: Read frames from video file.
% Step 2: Background substraction.
% Step 3: Feature extraction. 
    % Step 3-1: Motion History Image (MHI).
        % Step 3-1-1: Histogram of the MHI.
        % Step 3-1-2: Haar Wavelet transform of the MHI.
    % Step 3-2: Combine histogram + haar wavelet features.
% Step 4: Classification.

% Close all figures.
close all;

% Read the videos from the folder.
folderListing = dir(INPUT_FOLDER);

% The size of the feature vector (currently random).
featureSize = 20;
boxingTraining
boxingTesting
handclappingTraining
handclappingTesting
handwavingTraining
handwavingTesting


for i = 3:length(folderListing)
    subFolder = folderListing(i);
    if (subFolder.isdir)
        if (subFolder
        videoListing = dir(strcat(INPUT_FOLDER, currentClass.name));
    end
end    

% Feature set for all videos and their corresponding labels.
trainingData = zeros(numOfVideos, featureSize);
trainingLabels = zeros(numOfVideos);

for i = 3:length(folderListing)
    subFolder = folderListing(i);
    if (subFolder.isdir)
        videoListing = dir(strcat(INPUT_FOLDER, currentClass.name));
    end
    for j = 3:length(videoListing)
        if (~videoListing.isdir)
            trainingData = trainVideo(videoListing(i).name);
            
        end
    end
end