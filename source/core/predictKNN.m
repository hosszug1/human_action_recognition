function pLabels = predictKNN(KNNmodel, testingF)
%PREDICTKNN Function takes a K-nearest neighbour model as argument
%   and returns the predicted label(s) for input data.
%
%   P = predictKNN(MODEL, TESTDATA) returns vector P containing 'n'
%   number of labels where 'n' is the number of examples inputed
%
%       MODEL is a 'KNNClassifier' object that has been 'trained'
%       TESTDATA is a vector of 'FeatureVector' type objects
%
%   See also KNNCLASSIFIER, FEATUREVECTOR, PREDICTSVM, PREDICTNEWDATA.

% Get the data and labels from the model.
trainingL = KNNmodel.trainingLabels;
trainingF = KNNmodel.trainingFeatures;

pLabels = zeros(1, length(testingF));

% Standardise the data.
trainingF = standardiseData(trainingF);
testingF = standardiseData(testingF);

% Use the knnsearch function to find the nearest neihbours for the input
% data.
idx = knnsearch(trainingF, testingF, 'K', 1);

% Check the IDs of the previously found neighbours againts the label vector
% and get the prediction.
for i=1:length(pLabels)
    pLabels(i) = trainingL(mode(idx(i, :)));
end % for

end % function predictKNN

