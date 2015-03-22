function [allTrainingFiles, allTrainingLabels, allTestingFiles, allTestingLabels] = partitionData(classesInUse)
%PARTITIONDATA Function that partitions the data provided into 'convenient'
%   training and testing groups.
%
%   [TRF, TRL, TEF, TEL] = partitionData(CLASSES) will return 2 evenly
%   split sets of data (TRF - training files, TEF - testing files) and
%   their respective labels (TRL and TEL). The data is taken from a known
%   location.
%
%       CLASSES is a vector containing the action types desired to be used.
%
%   See also ACTIONTYPE.

% Location of the data.
INPUT_FOLDER = 'D:\Gabor\Workspace\Third Year Project\human_action_recognition\data\';

allTrainingFiles = [];
allTrainingLabels = [];
allTestingFiles = [];
allTestingLabels = [];

for i = 1:length(classesInUse)
    % Reset sizes of arrays.
    trainingVideos = [];
    trainingLabels = [];
    testingVideos = [];
    testingLabels = [];
    % Get the videos from each directory (needs to be lowercase).
    videos = dir(strcat(INPUT_FOLDER, lower(classesInUse(i).char)));
    videos = transpose(videos);
    % Get rid of current directory and previous directory handles.
    videos = videos(3:end);

    % The size of the training set.
    testingSize = floor(length(videos) / 2);
    trainingSize = length(videos) - testingSize;
    
    % Split into training and testing.
    trainingVideos = videos(1:trainingSize);
    trainingLabels(1:trainingSize) = classesInUse(i).int32;
    testingVideos = videos(trainingSize+1:end);
    testingLabels(1:testingSize) = classesInUse(i).int32;
    
    % Add them to the global training and testing data sets respectively.
    allTrainingFiles = [allTrainingFiles, trainingVideos];
    allTrainingLabels = [allTrainingLabels, trainingLabels];
    allTestingFiles = [allTestingFiles, testingVideos];
    allTestingLabels = [allTestingLabels, testingLabels];
    
end % for

end % function

