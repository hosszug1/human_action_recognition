classdef Constants
    %CONSTANTS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        height = 120;
        width = 160;
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

