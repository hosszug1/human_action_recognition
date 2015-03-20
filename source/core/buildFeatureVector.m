function featureVector = buildFeatureVector(videoPath, featureType)
%BUILDFEATUREVECTOR Function for building the feature vector data
%   structure for a given video.
%
%   V = buildFeatureVector(PATH, TYPE) will return a 'FeatureVector'
%   object V.
%
%       PATH is the path to the video file
%       TYPE is the type of features to be used.
%
%   See also FEATUREVECTOR, FEATUREVECTORTYPE.


% Extract frames from video.
[decodedFrames, numOfFrames, height, width] = extractFrames(videoPath);

% Transform frames into greyscale.
grayDecodedFrames = cast(zeros(height, width, numOfFrames), 'uint8');

for i = 1:numOfFrames
    currentFrame = decodedFrames(:, :, :, i);
    % Convert to grayscale.
    % imshow(currentFrame);
    grayFrame = rgb2gray(currentFrame);
    % figure, imshow(grayFrame);
    grayDecodedFrames(:, :, i) = grayFrame(:, :);
end % for

decodedFrames = grayDecodedFrames;

% Create matrix of binary images that represents the motion region of the
% frames.
binaryFrames = createBinary(decodedFrames, height, width, numOfFrames);

% Create the Motion History Image (MHI).
mhi = extractMHI(binaryFrames, height, width, numOfFrames);

% Construct a FeatureVector object based on the specified type. Save the
% data and its type in the object.
switch featureType
    case FeatureVectorType.MHI
        featureVector = FeatureVector(mhi, FeatureVectorType.MHI);
    case FeatureVectorType.MEI
        % Create the Motion Energy Image (MEI) from the MHI.
        % The MEI is simply a binary version of the MHI where
        % everything that is not black (i.e. 0), will be white
        % (i.e. 1).
        mei = im2bw(mhi, 0);
        
        featureVector = FeatureVector(mei, FeatureVectorType.MEI);
    case FeatureVectorType.Histogram
        % Create the histogram of MHI.
        [histOfMhi, indexes] = imhist(mhi);
        % figure, stem(histOfMhi, counts);

        % Discard the first value as this represents the number of black
        % pixels (with value 0) from the image/frame which is not useful
        % information for the histogram (does not contain any motion
        % information).
        histOfMhi = histOfMhi(2:end);
        indexes = indexes(2:end);
        
        featureVector = FeatureVector(histOfMhi, FeatureVectorType.Histogram);
    case FeatureVectorType.ConvMHI
        % Define the vertical and horizontal sobel kernels to be used with
        % convolution.
        verticalKernel = [-1 0 1; -2 0 2; -1 0 1];
        horizontalKernel = [1 2 1; 0 0 0; -1 -2 -1];
        verticalEdgeImage = my2DConvolution(mhi, verticalKernel, 'sobel');
        horizontalEdgeImage = my2DConvolution(mhi, horizontalKernel, 'sobel');
        % Calculate the edge strengthened image of the resultion
        % convolution.
        edgeStrengthImage = sqrt(verticalEdgeImage.^2 + horizontalEdgeImage.^2);
        
        featureVector = FeatureVector(edgeStrengthImage, FeatureVectorType.ConvMHI);
    case FeatureVectorType.Combined
        % Create the Motion Energy Image (MEI) from the MHI.
        % The MEI is simply a binary version of the MHI where
        % everything that is not black (i.e. 0), will be white
        % (i.e. 1).
        mei = im2bw(mhi, 0);
        
        % Create the histogram of MHI.
        [histOfMhi, indexes] = imhist(mhi);
        
        % Discard the first value as this represents the number of black
        % pixels (with value 0) from the image/frame which is not useful
        % information for the histogram (does not contain any motion
        % information).
        histOfMhi = histOfMhi(2:end);
        indexes = indexes(2:end);
        
        % Concatenate the data.
        combined = {mei, histOfMhi};
        
        featureVector = FeatureVector(combined, FeatureVectorType.Combined);        
    otherwise
        error('Invalid FeatureVectorType supplied!');
end % switch

end % function buildFeatureVector

