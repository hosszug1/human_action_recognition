classdef DataCreator
    %DATACREATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        BOXING = 1;
        HANDCLAPPING = 2;
        HANDWAVING = 3;
        JOGGING = 4;
        RUNNING = 5;
        WALKING = 6;
    end
    
    properties
        videoLocation;
        trainingData;
        validationData;
        testingData;
    end
        
    
    methods
        function this = DataCreator(path)
            this.videoLocation = path;
        end % constructor
    end
    
end

