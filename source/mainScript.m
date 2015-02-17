%%% Main script for automatic human action recognition %%%

clear all;
close all;

% Define the desired action classes to be used.
classesInUse = [ActionType.Boxing
    ActionType.Handclapping
    ActionType.Handwaving];

% Partition the files in 2 separate sets (and labels for training files).
[trainingFiles, trainingLabels, testingFiles] = partitionData(classesInUse);

numOfVideos = length(trainingFiles);

% Initialise first dimension of training data to be the number of video
% files.
% trainingData(1:numOfVideos) = FeatureVector();

% Create the training data.
%{
for i=1:numOfVideos
    % Get the feature vector for current video.
    trainingFiles(i).name
    try
        featureVector = buildFeatureVector(trainingFiles(i).name);
    catch err
        if (strcmp(err.identifier, 'MATLAB:audiovideo:VideoReader:UnknownCodec'))
            fprintf('Could not decode file: %s', trainingFiles(i).name);
            featureVector = FeatureVector(0, FeatureVectorType.MHI);
        else
            rethrow(err);
        end
    end
    trainingData(i) = featureVector;
end

%}