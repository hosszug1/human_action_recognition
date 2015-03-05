% Step 1: Read frames from video file.
% Step 2: Background substraction.
% Step 3: Feature extraction. 
    % Step 3-1: Motion History Image (MHI).
        % Step 3-1-1: Histogram of the MHI.
        % Step 3-1-2: Haar Wavelet transform of the MHI.
    % Step 3-2: Combine histogram + haar wavelet features.
% Step 4: Classification.

function featureVector = buildFeatureVector(videoPath, featureType)

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
binaryFrames = createBinary(decodedFrames, height, width, numOfFrames, 1);
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

% mhi = imerode(mhi, strel('square', 3));

% Construct a feature vector class and return it.
switch featureType
    case FeatureVectorType.MHI
        featureVector = FeatureVector(mhi, FeatureVectorType.MHI);
    case FeatureVectorType.MEI
        % Create MEI from MHI.
        mei = im2bw(mhi, 0);
        featureVector = FeatureVector(mei, FeatureVectorType.MEI);
    case FeatureVectorType.Histogram
        % Create histogram of MHI.
        [histOfMhi, indexes] = imhist(mhi);
        % figure, stem(histOfMhi, counts);

        % Discard the first value as it represents the number of "0" valued pixels
        % and we do not care about this as it does not contain motion information.
        histOfMhi = histOfMhi(2:end);
        indexes = indexes(2:end);
        % figure, stem(indexes, histOfMhi);
        featureVector = FeatureVector(histOfMhi, FeatureVectorType.Histogram);
    case FeatureVectorType.ConvMHI
        verticalKernel = [-1 0 1; -2 0 2; -1 0 1];
        horizontalKernel = [1 2 1; 0 0 0; -1 -2 -1];
        verticalEdgeImage = my2DConvolution(mhi, verticalKernel, 'sobel');
        horizontalEdgeImage = my2DConvolution(mhi, horizontalKernel, 'sobel');
        edgeStrengthImage = sqrt(verticalEdgeImage.^2 + horizontalEdgeImage.^2);
        % figure, imshow(edgeStrengthImage);
        
        % Eliminate insignificant parts of the image.
        % resultImage = 
        
        featureVector = FeatureVector(edgeStrengthImage, FeatureVectorType.ConvMHI);
    case FeatureVectorType.Combined
        % Create MEI from MHI.
        mei = im2bw(mhi, 0);
        % Create histogram of MHI.
        [histOfMhi, indexes] = imhist(mhi);
        % figure, stem(histOfMhi, counts);
        % Discard the first value as it represents the number of "0" valued pixels
        % and we do not care about this as it does not contain motion information.
        histOfMhi = histOfMhi(2:end);
        indexes = indexes(2:end);
        % figure, stem(indexes, histOfMhi);
        combined = {mei, histOfMhi};
        
        featureVector = FeatureVector(combined, FeatureVectorType.Combined);        
    otherwise
        
end

end

