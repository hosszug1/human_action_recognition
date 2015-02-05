function binaryFrames = createBinary(decodedFrames, height, width, numOfFrames)
%CREATEBINARY Summary of this function goes here
%   Detailed explanation goes here

binaryFrames = zeros(height, width, numOfFrames);

for i = 1:numOfFrames
    currentFrame = decodedFrames(:, :, i);
    level = graythresh(currentFrame);
    bwImage = im2bw(currentFrame, level);
    bwImage = ~bwImage;
    binaryFrames(:, :, i) = bwImage(:, :);
end

end

