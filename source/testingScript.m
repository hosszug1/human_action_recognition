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
path = 'person01_handwaving_d1_uncomp.avi';

% Extract frames from video.
[decodedFrames, numOfFrames, height, width] = extractFrames(path);

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
binaryFrames = createBinary(decodedFrames, height, width, numOfFrames, 1);
% binaryFrames = createBinary(decodedFrames, height, width, numOfFrames, 1);

% TEST - thresholding.
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

% Create MHI - currently testing 2 methods.

% Create mhi using default method.
tic;
mhi1 = extractMHI_alt(binaryFrames, height, width, numOfFrames);
% Time spent creating MHI using first method.
timeSpentOnMHI = toc;
% Show the result.
figure, imshow(mhi1);

% Reset time counter and create mhi using secondary method.
%{
tic;
mhi2 = extractMHI(binaryFrames, height, width, numOfFrames);
% Time spent creating MHI using second method.
TimeSpent2 = toc;
% Show both mhis.
subplot(1, 2, 1), imshow(mhi1),
subplot(1, 2, 2), imshow(mhi2);
%}










