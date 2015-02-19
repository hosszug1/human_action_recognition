%%% Test script to test how well feature extraction works for just 1 file.

% Close all figures.
clear all;
% Clear workspace.
close all;

INPUT_FILE = 'human_action_recognition\data\handwaving\person01_handwaving_d1_uncomp.avi';

featureVector = buildFeatureVector(INPUT_FILE);

featureData = featureVector.data;
featureType = featureVector.type.char;