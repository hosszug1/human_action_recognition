function binaryFrames = createBinary(decodedFrames, height, width, numOfFrames, method)

if (method == 0)
    binaryFrames = simpleTresholding(decodedFrames, height, width, numOfFrames);
elseif (method == 1)
    binaryFrames = frameSubtraction(decodedFrames, height, width, numOfFrames);
end

end

function frames = simpleTresholding(decFrames, h, w, n)

frames = zeros(h, w, n);

for i = 1:n
    currentFrame = decFrames(:, :, i);
    level = graythresh(currentFrame);
    bwImage = im2bw(currentFrame, level);
    bwImage = ~bwImage;
    frames(:, :, i) = bwImage(:, :);
end

end

function frames = frameSubtraction(decFrames, h, w, n)

frames = zeros(h, w, n);

for i = 2:n
    currentFrame = abs(decFrames(:, :, i) - decFrames(:, :, i-1));
    % level = graythresh(currentFrame);
    level = Constants.binaryThreshold;
    bwImage = im2bw(currentFrame, level);
    % bwImage = ~bwImage;
    frames(:, :, i) = bwImage(:, :);
end

end

