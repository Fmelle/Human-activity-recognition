function baseline_knn

%% Train and retrieve result of kNearestNeighbor

% Load data
load('features_train')
load('labels_train')
load('features_test')
load('labels_test')
load('features_validation')
load('labels_validation')

% Find best value of parameter k
k_max = 20;
optimalK = kNNValidateK(features_validation, ...
    labels_validation, features_test, labels_test, k_max);

% Perform training and classification
voteKNN = kNearestNeighbor(features_train, ... 
    labels_train, features_test, labels_test, optimalK);

labels = '32 49 50 51 52 53 54 55 56 57 58';
printmat(nConfkNN, 'Confusion matrix', labels, labels)

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

% Current score: % 0.942764076314565

% Create Confusion Matrix
conf = confusionmat(labelsTest, predictedLetter);
% Normalizing to the amount of each test letter
nConfkNN = conf./(sum(conf,2)*ones(1,m));
save('nConfkNN','nConfkNN');
end

function optimalK=kNNValidateK(featuresValid, labelsValid, featuresTest, labelsTest, k_max)
%% Validation [NumNeighbours Prediction], 10% validation data

%% Current results
% valid = [
%  1 0.;  2 0.;  3 0.;  4 0.; 
%  5 0.;  6 0.;  7 0.;  8 0.; 
%  9 0.; 10 0.; 11 0.; 12 0.;
% 13 0.; 14 0.; 15 0.; 16 0.;
% 17 0.; 18 0.; 19 0.; 20 0.
% ]
% Best: k = 1 Nearest Neigbors with % 0.955328059562587

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