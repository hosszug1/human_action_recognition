%%% Test script to test how well feature extraction works for just 1 file.

% Close all figures.
clear all;
% Clear workspace.
close all;

%%% Global parameters for the script.
featureMethod = FeatureVectorType.MHI;
% classifMethod = ClassifierType.KNN;

INPUT_FILE = 'human_action_recognition\data\handwaving\person01_handwaving_d1_uncomp.avi';

featureVector = buildFeatureVector(INPUT_FILE, featureMethod);

featureData = featureVector.data;
featureType = featureVector.type.char;