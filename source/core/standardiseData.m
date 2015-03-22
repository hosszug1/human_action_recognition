function standardisedFeatures = standardiseData(dataSet)
%STANDARDISEDATA Function that takes a data set as input and returns
%   its standardised version to match other function, class formats
%   used throughout this project.

global featureMethod;

% Standardise the data based on what feature type we use. The result will
% always be a linear vector (of different lengths).
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
end % switch

if (featureMethod == FeatureVectorType.Combined)
    for i=1:length(dataSet)
        mei = dataSet(i).data{1};
        hist = dataSet(i).data{2};
        standardisedFeatures(i, :) = [transpose(mei(:)) transpose(hist(:))];
    end % for
else
    for i=1:length(dataSet)
        standardisedFeatures(i, :) = dataSet(i).data(:);
    end % for
end % if

end % function standardiseData

