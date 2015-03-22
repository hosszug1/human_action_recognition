function data = createFeatureData(files)
%CREATEFEATUREDATA Function for creating feature vectors from multiple
%   files and storing them in a vector.
%
%   D = createFeatureData(FILES) will return a vector containing
%   'FeatureVector' type objects.
%
%       FILES is a vector of dir type structures that contains among
%       many other things, the paths to the video files needed for
%       feature extraction.
%
%   See also FEATUREVECTOR, FEATUREVECTORTYPE, DIR.

% Get the feature method from the global variable.
global featureMethod;

numOfVideos = length(files);

% Loop through the number of videos and create a feature vector for each.
for i=1:numOfVideos
    try
        featureVector = buildFeatureVector(files(i).name, featureMethod);
    catch err
        % If the decoding of the video fails, Create an "empty" feature 
        % vector to represent the corrupted file. Mark it as corrupt.
        if (strcmp(err.identifier, 'MATLAB:audiovideo:VideoReader:UnknownCodec'))
            fprintf('Could not decode file: %s\n', files(i).name);
            featureVector = FeatureVector(0, FeatureVectorType.Corrupted);
        else
            rethrow(err);
        end % if
    end % try
    data(i) = featureVector;
end % for

end % function createFeatureData

