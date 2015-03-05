classdef Constants
    %CONSTANTS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        height = 120;
        width = 160;
        decayParameter = 5;
        binaryThreshold = 0.2;
        trainingDataFileName = 'human_action_recognition\training_data.mat';
        testingDataFileName = 'human_action_recognition\testing_data.mat';
    end
    
    methods
        function updateHeight(newHeight)
            height = newHeight;
        end
        
        function updateWidth(newWidth)
            width = newWidth;
        end
    end
    
end

