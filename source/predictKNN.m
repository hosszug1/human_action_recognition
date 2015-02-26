function pLabels = predictKNN(KNNmodel, testingF)
%CLASSIFYKNN Summary of this function goes here
%   Detailed explanation goes here

trainingL = KNNmodel.trainingLabels;
trainingF = KNNmodel.trainingFeatures;

pLabels = zeros(1, length(testingF));

trainingF = standardiseData(trainingF);
testingF = standardiseData(testingF);

idx = knnsearch(trainingF, testingF, 'K', 1);

%{
if (length(idx) == length(testingF))
    fprintf('IDX length is same as testingD length.\n');
else
    fprintf('IDX is not even the same length as testingD...\n');
end
%}

for i=1:length(pLabels)
    pLabels(i) = trainingL(mode(idx(i, :)));
end

end

