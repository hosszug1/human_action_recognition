classdef Constants
%CONSTANTS Class used to represent constants that normally never
%   change throughout program runtime.
    
    properties (Constant)
        height = 120;
        width = 160;
        decayParameter = 5;
        binaryThreshold = 0.20;
        motionDetectionMethod = 1;
        trainingDataFileName = 'human_action_recognition\training_data.mat';
        testingDataFileName = 'human_action_recognition\testing_data.mat';
    end % properties
    
end % class Constants

