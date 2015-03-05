function standardisedFeatures = standardiseData(dataSet)
%STANDARDISEDATA Summary of this function goes here
%   Detailed explanation goes here

global featureMethod;

% Try to find the first feature vector that's not corrupted, loop until one
% is found, break if one is found.
switch featureMethod
    case {FeatureVectorType.MHI, FeatureVectorType.MEI}
        standardisedFeatures = zeros(length(dataSet), (Constants.height * Constants.width));
    case FeatureVectorType.ConvMHI
        
    case FeatureVectorType.Histogram
        standardisedFeatures = zeros(length(dataSet), 255);
    case FeatureVectorType.Corrupted
        % If the very first file was corrupted and feature vectores were
        % not extracted successfully from it, try the next one, etc.
    case FeatureVectorType.Combined
        standardisedFeatures = zeros(length(dataSet), (Constants.height * Constants.width + 255));
    otherwise
        % If it's neither of the above, something horrible must have
        % happened.
        throwException('classify', 'FeatureVectorType not recognised');
end

% size(standardisedFeatures)
% size(dataSet(1).data(:))
if (featureMethod == FeatureVectorType.Combined)
    for i=1:length(dataSet)
        mei = dataSet(i).data{1};
        hist = dataSet(i).data{2};
        standardisedFeatures(i, :) = [transpose(mei(:)) transpose(hist(:))];
    end
else
    for i=1:length(dataSet)
        standardisedFeatures(i, :) = dataSet(i).data(:);
    end
end

end

