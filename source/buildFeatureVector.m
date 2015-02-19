% Step 1: Read frames from video file.
% Step 2: Background substraction.
% Step 3: Feature extraction. 
    % Step 3-1: Motion History Image (MHI).
        % Step 3-1-1: Histogram of the MHI.
        % Step 3-1-2: Haar Wavelet transform of the MHI.
    % Step 3-2: Combine histogram + haar wavelet features.
% Step 4: Classification.

function featureVector = buildFeatureVector(videoPath)

% Extract frames from video.
[decodedFrames, numOfFrames, height, width] = extractFrames(videoPath);

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
binaryFrames = createBinary(decodedFrames, height, width, numOfFrames, 0);
% binaryFrames = createBinary(decodedFrames, height, width, numOfFrames, 1);

% TEST - Display a few frames (usually 5) to check quality of binary
% image filtration.
% showFrames(decodedFrames, binaryFrames, 5);

% Create MHI - currently testing 2 methods.

% Create mhi using default method.
% tic;
mhi = extractMHI_alt(binaryFrames, height, width, numOfFrames);
% Time spent creating MHI using first method.
% timeSpentOnMHI = toc;
% showFrames(decodedFrames, mhi, 5);
% figure, imshow(mhi);

% Create histogram of MHI.
% [histOfMhi, indexes] = imhist(mhi);
% figure, stem(histOfMhi, counts);


% Construct a feature vector class and return it.
featureVector = FeatureVector(mhi, FeatureVectorType.MHI);

end
