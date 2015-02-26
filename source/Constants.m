classdef Constants
    %CONSTANTS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        height = 120;
        width = 160;
        decayParameter = 5;
        binaryThreshold = 0.2;
        trainingDataFileName = 'training_data.mat';
        testingDataFileName = 'testing_data.mat';
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

