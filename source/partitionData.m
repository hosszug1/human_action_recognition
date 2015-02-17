function [allTrainingFiles, allTrainingLabels, allTestingFiles] = partitionData(classesInUse)
%CREATETRAININGDATA Summary of this function goes here
%   Detailed explanation goes here

%%% GLOBAL VARIABLES %%%
INPUT_FOLDER = 'D:\Gabor\Workspace\Third Year Project\human_action_recognition\data\';

allTrainingFiles = [];
allTrainingLabels = [];
allTestingFiles = [];

for i = 1:length(classesInUse)
    % Get the videos from each directory (needs to be lowercase).
    videos = dir(strcat(INPUT_FOLDER, lower(classesInUse(i).char)));
    videos = transpose(videos);
    % Get rid of current directory and previous directory handles.
    videos = videos(3:end);

    % The size of the training set.
    trainingSize = floor(length(videos) / 2);
    
    % Split into training and testing.
    trainingVideos = videos(1:trainingSize);
    trainingLabels(1:trainingSize) = classesInUse(i).int32;
    trainingSize
    b = length(trainingLabels)
    testingVideos = videos(trainingSize+1:end);
    
    % Add them to the global training and testing data sets respectively.
    allTrainingFiles = [allTrainingFiles, trainingVideos];
    allTrainingLabels = [allTrainingLabels, trainingLabels];
    allTestingFiles = [allTestingFiles, testingVideos];
    
end % for

end % function

