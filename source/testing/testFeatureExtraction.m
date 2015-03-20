%%% Test script to test how well feature extraction works for just 1 file.

% Close all figures.
clear all;
% Clear workspace.
% close all;

tic;

global featureMethod;
%%% Global parameters for the script.
featureMethod = FeatureVectorType.MEI;
% classifMethod = ClassifierType.KNN;

INPUT_FILE = 'human_action_recognition\new_video.avi';

featureVector = buildFeatureVector(INPUT_FILE, featureMethod);

featureData = featureVector.data;
featureType = featureVector.type.char;

timeSpent = toc
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
        
end
figure, imshow(featureData);