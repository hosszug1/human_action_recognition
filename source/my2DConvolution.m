function convolutedImage = my2DConvolution(inputImage, seKernel, type)
%MY2DCONVOLUTION A function that performs 2D image convolution on an
% image.
%
%   Author: Gabor Hosszu
%
%   The following are the input parameters to the function:
%
%   inputImage = the input image desired to be convoluted (Height * Width);
%   seKernel = kernel used for convolution;
%   type = can be 'sobel' or anything else
%
%

% Get size of structuring element kernel.
[seHeight, seWidth] = size(seKernel);

halfSeHeight = floor(seHeight / 2);
halfSeWidth = floor(seWidth / 2);

% Get size of image.
[height, width] = size(inputImage);
convolutedImage = zeros(height, width);

for i = 1:height
    % Check to make sure we don't go out of the borders of the image.
    % And if we do, calculate by 'how much' - padding value.
    if (i - halfSeHeight <= 1)
        seX1 = 1;
        topPadding = halfSeHeight - (i - 1);
    else
        seX1 = i - halfSeHeight;
        topPadding = 0;
    end
    if (i + halfSeHeight >= height)
        seX2 = height;
        bottomPadding = halfSeHeight - (height - i);
    else
        seX2 = i + halfSeHeight;
        bottomPadding = 0;
    end
    for j = 1:width
        % Check to make sure we don't go out of the borders of the image.
    % And if we do, calculate by 'how much' - padding value.
        if (j - halfSeWidth <= 1)
            seY1 = 1;
            leftPadding = halfSeWidth - (j - 1);
        else
            seY1 = j - halfSeWidth;
            leftPadding = 0;
        end
        if (j + halfSeWidth >= width)
            seY2 = width;
            rightPadding = halfSeWidth - (width - j);
        else
            seY2 = j + halfSeWidth;
            rightPadding = 0;
        end
        
        % Initialise the padded SE with zeros.
        paddedSE = zeros(seHeight, seWidth);
        
        % This is the tricky part, now that we've seen how much we need to
        % pad the part of the image covered by the SE, we basically change
        % those values in the 'paddedSE' variable that are overlapping with
        % the image, the rest will remain zero.
        paddedSE(1+topPadding:end-bottomPadding, 1+leftPadding:end-rightPadding) = inputImage(seX1:seX2, seY1:seY2);
        
        % Calculate convoluted values.
        convolutedSE = paddedSE.*seKernel;
        a = sum(sum(convolutedSE));
        if (strcmp(type, 'sobel'))
            b = a / 1;
        else
            b = a / sum(sum(seKernel));
        end
        
        convolutedImage(i, j) = b;
    end
end

end


