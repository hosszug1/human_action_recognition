%%% Main script for automatic human action recognition

% Global sort of parameters. Change to tweak testing script.
% Folder for getting videos.
INPUT_FOLDER = 'human_action_recognition\data\handwaving';

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
videoStructs = dir(INPUT_FOLDER);

for i = 3:20
    classifyVideo(videoStructs(i).name)
end