classdef SVMClassifier
%SVMCLASSIFIER Class that represents a Support Vector Machine (SVM)
%   classifier.
%
%   See also CREATESVM, PREDICTSVM, KNNCLASSIFIER, CREATEKNN, PREDICTKNN.

    properties
        id;
        classInUse;
        accuracy = 0;
        pLabels;
        model;
        probEstimates;
    end % properties
    
    methods
        function this = SVMClassifier(id, classInUse)
            this.id = id;
            this.classInUse = classInUse;
        end % constructor
    end % methods
    
end % class SVMClassifier

