function predictedLabels = classify(testingData, testingLabels, trainingData, trainingLabels, classifMethod)
%CLASSIFY 

% Assume that every feature vector is the same size, was created the same
% way, etc. Therefore check what method of classifying to use before the
% loop. Check the type of feature vector for the first (non-corrupted) 
% element. Again, should be the same for every other, there will be 
% checks for this.

% Try to find the first feature vector that's not corrupted, loop until one
% is found, break if one is found.
for i=1:length(testingData)
    switch testingData(i).type
        case FeatureVectorType.MHI
            trainingFeatures = zeros(length(trainingData), (Constants.height * Constants.width));
            testingFeatures = zeros(length(testingData), (Constants.height * Constants.width));
            break;
        case FeatureVectorType.Histogram
            trainingFeatures = zeros(length(trainingData), 256);
            testingFeatures = zeros(length(testingData), 256);
            break;
        case FeatureVectorType.Corrupted
            % If the very first file was corrupted and feature vectores were
            % not extracted successfully from it, try the next one, etc.
        otherwise
            % If it's neither of the above, something horrible must have
            % happened.
            throwException('classify', 'FeatureVectorType not recognised');
    end
end
        
for i=1:length(testingData)
    testingFeatures(i, :) = testingData(i).data(:);
end

for i=1:length(trainingData)
    trainingFeatures(i, :) = trainingData(i).data(:);
end

predictedLabels = classifyLinear(testingFeatures, testingLabels, trainingFeatures, trainingLabels, classifMethod);

end

function pLabels = classifyLinear(testingF, testingL, trainingF, trainingL, classifM)

pLabels = zeros(1, length(testingL));

switch classifM
    case ClassifierType.KNN
        % KNN
        
        idx = knnsearch(trainingF, testingF);
        
        if (length(idx) == length(testingF))
            fprintf('IDX length is same as testingD length.\n');
        else
            fprintf('IDX is not even the same length as testingD...\n');
        end
        
        for i=1:length(pLabels)
            pLabels(i) = trainingL(idx(i));
        end

    case ClassifierType.SVM
        % SVM
        trainingL = transpose(trainingL);
        testingL = transpose(testingL);
        model = svmtrain(trainingL, trainingF);
        [pLabels, accuracy, probData] = svmpredict(testingL, testingF, model);
        fprintf('The accuracy of svmpredict is: %f\n', accuracy);
    otherwise
        % If it's neither of the above, something horrible must have
        % happened.
        throwException('classifyMHI', 'ClassifierType not recognised');
end

end

