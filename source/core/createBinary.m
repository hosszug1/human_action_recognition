function binaryFrames = createBinary(decodedFrames, height, width, numOfFrames)
%CREATEBINARY Function for creating binary/black and white images
%   from a set of grayscale ones.
%
%   BF = createBinary(FRAMES, H, W, N) will return a H x W x N matrix
%   containing N tresholded (binary) images of the original frames.
%
%       FRAMES is the original H x W x N matrix of video frames
%       H is the height of the frames
%       W is the width of the frames
%       N is the number of frames
%
%   See also EXTRACTFRAMES.

% According to the motion detection method desired to be used, call the
% corresponding function for the tresholding.
switch Constants.motionDetectionMethod
    case 0
        binaryFrames = simpleTresholding(decodedFrames, height, width, numOfFrames);
    case 1
        binaryFrames = frameSubtraction(decodedFrames, height, width, numOfFrames);
    otherwise
        error('Invalid motion detection method selected.');
end % switch

end % function createBinary

% Simple tresholding is based on color with the built-in matlab functions.
function frames = simpleTresholding(decFrames, h, w, n)

frames = zeros(h, w, n);

for i = 1:n
    currentFrame = decFrames(:, :, i);
    level = graythresh(currentFrame);
    bwImage = im2bw(currentFrame, level);
    bwImage = ~bwImage;
    frames(:, :, i) = bwImage(:, :);
end % for

end % function simpleTresholding

% Frame-by-frame subtraction method.
function frames = frameSubtraction(decFrames, h, w, n)

frames = zeros(h, w, n);

for i = 2:n
    % Get the absolute euclidian distance between two corresponding
    % frames.
    currentFrame = abs(decFrames(:, :, i) - decFrames(:, :, i-1));
    
    % Treshold the image using a pre-defined parameter.
    level = Constants.binaryThreshold;
    bwImage = im2bw(currentFrame, level);
    frames(:, :, i) = bwImage(:, :);
end % for

end % function frameSubtraction

