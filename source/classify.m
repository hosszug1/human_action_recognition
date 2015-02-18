function predictedLabels = classify(testingData, trainingData, trainingLabels, classifMethod)
%CLASSIFY 

% Assume that every feature vector is the same size, was created the same
% way, etc. Therefore check what method of classifying to use before the
% loop. Check the type of feature vector for the first element. Again,
% should be the same for every other, there will be checks for this.

% Try to find the first feature vector that's not corrupted, loop until one
% is found, break if one is found.
for i=1:length(testingData)
    switch (testingData(i).type)
        case (FeatureVectorType.MHI)
            predictedLabels = classifyMHI(testingData, trainingData, trainingLabels, classifMethod);
            break;
        case (FeatureVectorType.Combined)
            break;
        case (FeatureVectorType.Corrupted)
            % If the very first file was corrupted and feature vectores were
            % not extracted successfully from it, try the next one, etc.
        otherwise
            % If it's neither of the above, something horrible must have
            % happened.
            throwException('classify', 'FeatureVectorType not recognised');
    end
end

end

function pLabels = classifyMHI(testingD, trainingD, trainingL, classifM)
    pLabels = zeros(1:length(testingD));
    switch(classifM)
        case (ClassifierType.KNN)
            % KNN
            testingMHI = zeros(length(testingD), constants.Height, constants.Width);
            for i=1:length(testingD)
                testingMHI(i) = testingD.data;
            end
            idx = knnsearch(trainingD, testingD);
            for i=1:length()
                
                
        case (ClassifierType.SVN)
            % SVN
        otherwise
            % If it's neither of the above, something horrible must have
            % happened.
            throwException('classifyMHI', 'ClassifierType not recognised');
    end
end

