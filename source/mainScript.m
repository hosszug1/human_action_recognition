%%% Main script for automatic human action recognition
% Step 1: Read frames from video file.
% Step 2: Background substraction.
% Step 3: Feature extraction. 
    % Step 3-1: Motion History Image (MHI).
        % Step 3-1-1: Histogram of the MHI.
        % Step 3-1-2: Haar Wavelet transform of the MHI.
    % Step 3-2: Combine histogram + haar wavelet features.
% Step 4: Classification.

% Temporary testing.
path = 'person01_boxing_d1_uncomp.avi';

% Extract frames from video.
[decodedFrames, numOfFrames, width, height] = extractFrames(path);

% TEST - Print out number of frames.
numOfFrames

% TEST - Show a couple of frames
%{
firstFrame = decodedFrames(:, :, :, 1);
secondFrame = decodedFrames(:, :, :, 10);

firstFrameGray = rgb2gray(firstFrame);
secondFrameGray = rgb2gray(secondFrame);

imshow(firstFrame);
figure, imshow(firstFrameGray);
figure, imshow(secondFrame);
figure, imshow(secondFrameGray);
%}

% Transform frames into greyscale (in case it hasn't been done.
grayDecodedFrames = zeros(width, height, numOfFrames);

for i = 1:numOfFrames
    currentFrame = decodedFrames(:, :, :, i);
    % Convert to grayscale.
    grayFrame = rgb2gray(currentFrame);
    grayDecodedFrames(:, :, i) = grayFrame;
end

% decodedFrames = grayDecodedFrames;

% Background substraction - currently in progress.

% Create MHI from frames.

% mei = extractMEI(decodedFrames, numOfFrames):

% mhi = extractMHI(decodedFrames, numOfFrames);












