classdef FeatureVector
    %FEATUREVECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        data;
        type;
    end
    
    methods
        function this = FeatureVector(data, type)
           this.data = data;
           this.type = type;
        end
    end
end

