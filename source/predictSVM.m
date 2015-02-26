function [svmArray, pLabels] = predictSVM(svmArray, testingData, testingL, classesInUse)
%CLASSIFY 

% This will return the data in a 'universally standard' format we keep
% throughout the system.
testingF = standardiseData(testingData);

pLabels = zeros(1, length(testingL));
        
% Need to create as many SVMs as the number of classes we have.
        
% Necessary formatting.
testingL = transpose(testingL);

for i=1:length(svmArray)

    % svmArray(i) = svmArray(i);
    classesNotUsed = setdiff(classesInUse, svmArray(i).classInUse);
    
    binaryTestingL = changem(testingL, [-1 -1], classesNotUsed);
    binaryTestingL = changem(binaryTestingL, 1, svmArray(i).classInUse);

    [svmArray(i).pLabels, svmArray(i).accuracy, ~] = svmpredict(binaryTestingL, testingF, svmArray(i).model);
    % newSVM.pLabels
    fprintf('The accuracy of SVM number %d is: %f\n', svmArray(i).id, svmArray(i).accuracy);

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
        % fprintf('pLabels: %d', length(svmArray(j).pLabels));
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
        % fprintf('No hit has been found for the data, this is VERY VERY BAD!\n');
    end
end

end
