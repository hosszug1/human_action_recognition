function binaryFrames = createBinary(decodedFrames, height, width, numOfFrames)
%CREATEBINARY Summary of this function goes here
%   Detailed explanation goes here

binaryFrames = zeros(height, width, numOfFrames);

for i = 1:numOfFrames
    currentFrame = decodedFrames(:, :, i);
    level = graythresh(currentFrame);
    bwImage = im2bw(currentFrame, level);
    binaryFrames(:, :, i) = bwImage(:, :);
end


% TEST - thresholding.
%{
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
%}

end

