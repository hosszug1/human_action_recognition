function acc = experimentSVM(trainData, trainLabel, testData, testLabel, numLabels)
%TESTSVM Summary of this function goes here
%   Detailed explanation goes here

trainData = standardiseData(trainData);
testData = standardiseData(testData);
trainLabel = transpose(trainLabel);
testLabel = transpose(testLabel);

%# train one-against-all models
model = cell(numLabels,1);
for k=1:numLabels
    model{k} = svmtrain(double(trainLabel==k), trainData, '-t 1 -b 1');
end

%# get probability estimates of test instances using each model
prob = zeros(length(testLabel),numLabels);
for k=1:numLabels
    [~,~,p] = svmpredict(double(testLabel==k), testData, model{k}, '-b 1');
    prob(:,k) = p(:,model{k}.Label==1);    %# probability of class==k
end

%# predict the class with the highest probability
[~,pred] = max(prob,[],2);
acc = sum(pred == testLabel) ./ numel(testLabel)    %# accuracy
C = confusionmat(testLabel, pred)                   %# confusion matrix

end

