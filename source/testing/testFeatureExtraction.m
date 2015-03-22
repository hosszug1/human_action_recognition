%TESTFEATUREEXTRACTION 
%   Script to test feature extraction for just 1 input example.

% Clear workspace.
clear all;
% Close all figures.
close all;

tic;

global featureMethod;
featureMethod = FeatureVectorType.ConvMHI;

% The input example is just an arbitrary video from the dataset.
INPUT_FILE = 'human_action_recognition\data\handwaving\person06_handwaving_d4_uncomp.avi';

featureVector = buildFeatureVector(INPUT_FILE, featureMethod);

featureData = featureVector.data;
featureType = featureVector.type.char;

% Save and print the time spent on building the feature vector for the
% video.
timeSpent = toc

% Based on what type of features are used, display the data in different
% ways (e.g. for an image, show a figure of it, for a histogram, plot the
% data, etc).
switch featureType
    case FeatureVectorType.MHI
        figure, imshow(featureData);
    case FeatureVectorType.MEI
        figure, imshow(featureData);
    case FeatureVectorType.Histogram
        hist = featureData;
        indexes = zeros(255, 1);
        for i=1:255
            indexes(i) = i;
        end
        % indexes = transpose(indexes);
        figure, stem(indexes, hist);
    case FeatureVectorType.ConvMHI
        figure, imshow(featureData);
    case FeatureVectorType.Combined
        mei = featureData{1};
        figure, imshow(mei);
        hist = featureData{2};
        indexes = zeros(1, 255);
        for i=1:255
            indexes(i) = i;
        end
        figure, stem(indexes, hist);
    otherwise
        
end % switch