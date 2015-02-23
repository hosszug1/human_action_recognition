classdef SVMClassifier
    %SVMCLASSIFIER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id;
        classInUse;
        accuracy = 0;
        pLabels;
    end
    
    methods
        function this = SVMClassifier(id, classInUse)
            this.id = id;
            this.classInUse = classInUse;
        end
    end
    
end

