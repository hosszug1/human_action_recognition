%%% Test script to test how well feature extraction works for just 1 file.

% Close all figures.
clear all;
% Clear workspace.
close all;

tic;

global featureMethod;
%%% Global parameters for the script.
featureMethod = FeatureVectorType.ConvMHI;
% classifMethod = ClassifierType.KNN;

INPUT_FILE = 'human_action_recognition\data\boxing\person12_boxing_d1_uncomp.avi';

featureVector = buildFeatureVector(INPUT_FILE, featureMethod);

featureData = featureVector.data;
featureType = featureVector.type.char;

timeSpent = toc

figure, imshow(featureData);