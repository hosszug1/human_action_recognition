function showFrames(frames1, frames2, frameNo)    

% TEST - thresholding.
for i = 1:frameNo
    % figure, imshow([decodedFrames(:, :, i), binaryFrames(:, :, i)]);
    % A = [decodedFrames(:, :, i); binaryFrames(:, :, i)];
    % figure, imshow(A);
    % figure, imshow(decodedFrames(:, :, i));
    % figure, imshow(binaryFrames(:, :, i));
    figure,
    subplot(1, 2, 1), imshow(frames1(:, :, i)),
    if (nargin == 3)
        subplot(1, 2, 2), imshow(frames2(:, :, i));
    end
end

end

