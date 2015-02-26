classdef KNNClassifier
    %SVMCLASSIFIER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % id;
        accuracy = 0;
        trainingLabels;
        trainingFeatures;
    end
    
    methods
        function this = KNNClassifier(trainingFeatures, trainingLabels)
            % this.id = id;
            this.trainingLabels = trainingLabels;
            this.trainingFeatures = trainingFeatures;
        end
    end
    
end

