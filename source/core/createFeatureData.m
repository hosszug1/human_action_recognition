function data = createFeatureData(files)
%CREATETRAININGDATA Summary of this function goes here
%   Detailed explanation goes here

global featureMethod;

% Initialise first dimension of the data to be the number of video
% files.
% data(1:numOfVideos) = FeatureVector();

numOfVideos = length(files);

% Create the data.
for i=1:numOfVideos
    % Get the feature vector for current video.
    % trainingFiles(i).name
    try
        featureVector = buildFeatureVector(files(i).name, featureMethod);
    catch err
        if (strcmp(err.identifier, 'MATLAB:audiovideo:VideoReader:UnknownCodec'))
            fprintf('Could not decode file: %s\n', files(i).name);
            % Create an "empty" feature vector to represent the corrupted
            % file.
            featureVector = FeatureVector(0, FeatureVectorType.Corrupted);
        else
            rethrow(err);
        end
    end
    data(i) = featureVector;
end

end

