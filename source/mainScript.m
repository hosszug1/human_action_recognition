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

% Background substraction - currently in progress.

% Create MHI from frames.

binaryFrames = zeros(height, width, numOfFrames);

for i = 1:numOfFrames
    currentFrame = decodedFrames(:, :, i);
    level = graythresh(currentFrame);
    bwImage = im2bw(currentFrame, level);
    binaryFrames(:, :, i) = bwImage(:, :);
end

% Test thresholding.
for i = 1:5
    % figure, imshow([decodedFrames(:, :, i), binaryFrames(:, :, i)]);
    % A = [decodedFrames(:, :, i); binaryFrames(:, :, i)];
    % figure, imshow(A);
    % figure, imshow(decodedFrames(:, :, i));
    % figure, imshow(binaryFrames(:, :, i));
    figure,
    subplot(1, 2, 1), imshow(decodedFrames(:, :, i)),
    subplot(1, 2, 2), imshow(binaryFrames(:, :, i));
end

% mhi = extractMHI(decodedFrames, binaryFrames, numOfFrames);












