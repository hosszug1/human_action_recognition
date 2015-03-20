classdef FeatureVectorType < uint8
%FEATUREVECTORTYPE Enumeration class used to represent the possible
%   feature types supported by the system.
    
    enumeration
        MHI (1)
        MEI (2)
        ConvMHI (3)
        Histogram (4)
        Combined (5)
        Corrupted (6)
    end
    
end

