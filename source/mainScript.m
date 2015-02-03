%%% Main script for automatic human action recognition
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

% Temporary testing.
path = 'person01_boxing_d1_uncomp.avi';

% Extract frames from video.
[decodedFrames, numOfFrames, height, width] = extractFrames(path);

% TEST - Print out number of frames.
numOfFrames

% Transform frames into greyscale (in case it hasn't been done.
grayDecodedFrames = cast(zeros(height, width, numOfFrames), 'uint8');

for i = 1:numOfFrames
    currentFrame = decodedFrames(:, :, :, i);
    % Convert to grayscale.
    % imshow(currentFrame);
    grayFrame = rgb2gray(currentFrame);
    % figure, imshow(grayFrame);
    grayDecodedFrames(:, :, i) = grayFrame(:, :);
end

decodedFrames = grayDecodedFrames;

% Create matrix of binary images (motion energy image or bw).
binaryFrames = createBinary(decodedFrames, height, width, numOfFrames);

% Create MHI.
% mhi = extractMHI(decodedFrames, binaryFrames, numOfFrames);












