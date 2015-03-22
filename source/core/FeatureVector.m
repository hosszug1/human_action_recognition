classdef FeatureVector
%FEATUREVECTOR Class that represents one feature vector for one video
%   file. It contains the data and its type.
%
%   See also FEATUREVECTORTYPE.
    
    properties
        data;
        type;
    end % properties
    
    methods
        function this = FeatureVector(data, type)
           this.data = data;
           this.type = type;
        end % constructor
    end % methods
    
end % class FeatureVector

