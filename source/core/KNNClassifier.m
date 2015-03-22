classdef KNNClassifier
%KNNCLASSIFIER Class that represents a K-nearest neighbour (KNN)
%   classifier.
%
%   See also CREATEKNN, PREDICTKNN, SVMCLASSIFIER, CREATESVM, PREDICTSVM.
    
    properties
        % id;
        accuracy = 0;
        trainingLabels;
        trainingFeatures;
    end % properties
    
    methods
        function this = KNNClassifier(trainingFeatures, trainingLabels)
            % this.id = id;
            this.trainingLabels = trainingLabels;
            this.trainingFeatures = trainingFeatures;
        end % constructor
    end % methods
    
end % class KNNClassifier

