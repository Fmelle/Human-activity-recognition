function baseline_knn

%% Train and retrieve result of kNearestNeighbor

% Load data
load('features_train')
load('labels_train')
load('features_test')
load('labels_test')
load('features_valid')
load('labels_valid')

% Find best value of parameter k
k_max = 20;
optimalK = kNNValidateK(features_left_valid, ...
    labels_left_valid, features_left_test, labels_left_test, k_max);

% Perform training and classification
voteKNN = kNearestNeighbor(features_train, ... 
    labels_train, features_test, labels_test, optimalK);

end


function vote=kNearestNeighbor(featuresTrain, labelsTrain, featuresTest, labelsTest, optimalK)
%% Create the kNN classifier
knn = ClassificationKNN.fit(featuresTrain, labelsTrain,...
    'NumNeighbors',optimalK,'BreakTies','nearest');

% Test on remaining data
predictedLetter = knn.predict(featuresTest);
% Establish prediction overview 1 - 57 classes (classes are 32-57)
m = max(labelsTrain);
[n d] = size(featuresTest);
vote=zeros(n,m);
for i=1:n
    vote(i,predictedLetter(i))=1;
end
% Calc and Post correctness percentage
sum(predictedLetter==labelsTest)/n % Print % score
% Final baseline score: % 0.6000918 

% Create Confusion Matrix
conf = confusionmat(labelsTest, predictedLetter);
% Normalizing to the amount of each test letter
nConfkNN = conf./(sum(conf,2)*ones(1,m));
save('nConfkNN','nConfkNN');
end

function optimalK=kNNValidateK(featuresValid, labelsValid, featuresTest, labelsTest, k_max)
%% Validation [NumNeighbours Prediction], 10% validation data
% Best overall: k = 11

%% Current results
% valid = [
%  1 0.5831;  2 0.5799;  3 0.5895;  4 0.5946; 
%  5 0.6042;  6 0.6019;  7 0.6056;  8 0.6024; 
%  9 0.6042; 10 0.6028; 11 0.6070; 12 0.6051;
% 13 0.6038; 14 0.6084; 15 0.6015; 16 0.6028;
% 17 0.6000; 18 0.6024; 19 0.5996; 20 0.6006
% ]
% Best: k = 14 Nearest Neigbors with % 0.60836

%% Algorithm

% Loop through kNN varying k from 1 to k_max
kNNscore = zeros(k_max,1);
for k=1:k_max
    % Create the kNN classifier
    knn = ClassificationKNN.fit(featuresValid, labelsValid,...
        'NumNeighbors',k,'BreakTies','nearest');
    % Test on remaining data
    predictedLetter = knn.predict(featuresTest);
    % Establish prediction overview
    m = max(labelsValid);
    [n d] = size(featuresTest);
    vote=zeros(n,m);
    for i=1:n
        vote(i,predictedLetter(i))=1;
    end
    % Calc and print correctness with corresponding k
    kNNscore(k) = sum(predictedLetter==labelsTest)/n; % Print % score
end

[highest_performance, optimalK] = max(kNNscore)

end