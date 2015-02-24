function model = createClassifierModel(trainingData, trainingLabels, classifMethod)
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
            trainingFeatures = zeros(length(trainingData), 255);
            testingFeatures = zeros(length(testingData), 255);
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

predictedLabels = classifyLinear(testingFeatures, testingLabels, trainingFeatures, trainingLabels, classifMethod, classesInUse);

end

function pLabels = classifyLinear(testingF, testingL, trainingF, trainingL, classifM, classesInUse)

pLabels = zeros(1, length(testingL));

switch classifM
    case ClassifierType.KNN
        % KNN
        model = trainingF;
    case ClassifierType.SVM
        %%%%%%%%%%%%%%%%%%%%% SVM %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Need to create as many SVMs as the number of classes we have.
        
        % Necessary formatting.
        trainingL = transpose(trainingL);
        testingL = transpose(testingL);
        svmArray = [];
        
        for i=1:length(classesInUse)
            
            % Create a new SVM object.
            newSVM = SVMClassifier(i, classesInUse(i));
            % See which are the classes not used.
            classesNotUsed = setdiff(classesInUse, newSVM.classInUse);            
            
            % Change training and testing data to suit the binary SVM.
            binaryTrainingL = changem(trainingL, [-1 -1], classesNotUsed);
            % binaryTrainingL
            binaryTrainingL = changem(binaryTrainingL, 1, newSVM.classInUse);
            % binaryTrainingL
            binaryTestingL = changem(testingL, [-1 -1], classesNotUsed);
            binaryTestingL = changem(binaryTestingL, 1, newSVM.classInUse);
            
            model = svmtrain(binaryTrainingL, trainingF);
                        
            [newSVM.pLabels, newSVM.accuracy, ~] = svmpredict(binaryTestingL, testingF, model);
            % newSVM.pLabels
            fprintf('The accuracy of SVM number %d is: %f\n', newSVM.id, newSVM.accuracy);
            
            svmArray = [svmArray; newSVM];
        end
        
        % Sort the SVM array according to accuracies.
        [~, idx] = sort([svmArray.accuracy]);
        svmArray = svmArray(idx);
        label = 0;
        
        for i=1:length(pLabels)
            % For each label, we check in order of accuracies of the SVM,
            % if the respective SVM has a 'hit' or not. If yes, we trust it
            % and we stop looking at the others.
            matchFound = 0;
            for j=1:length(svmArray)
                if (svmArray(j).pLabels(i) == 1)
                    label = svmArray(j).classInUse;
                    matchFound = 1;
                    break;
                else
                    matchFound = 0;
                end
            end
            
            pLabels(i) = label;
            if (matchFound == 0)
                fprintf('No hit has been found for the data, this is VERY VERY BAD!\n');
            end
        end       
    otherwise
        % If it's neither of the above, something horrible must have
        % happened.
        throwException('classifyMHI', 'ClassifierType not recognised');
end

end

