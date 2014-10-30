function baseline_knn

%% Train and retrieve result of kNearestNeighbor

% Load left arm data
load('features_left_train')
load('labels_left_train')
load('features_left_test')
load('labels_left_test')

% Perform training and classification
voteKNN_left = kNearestNeighbor(features_left_train, ... 
    labels_left_train, features_left_test, labels_left_test);

% Load right arm data
load('features_right_train')
load('labels_right_train')
load('features_right_test')
load('labels_right_test')

% Perform training and classification
voteKNN_right = kNearestNeighbor(features_right_train, ...
    labels_right_train, features_right_test, labels_right_test);

%% Perform validation research on parameter k in kNN

% Load left arm validation data
%load('features_left_valid')
%load('labels_left_valid')

% Find best value of parameter k
%optimalK = kNNValidateK(features_left_valid, ...
%    labels_left_valid, features_left_test, labels_left_test);

% Load right arm validation data
%load('features_right_valid')
%load('labels_right_valid')

%optimalK = kNNValidateK(features_right_valid, ...
%    labels_right_valid, features_right_test, labels_right_test);

end


function vote=kNearestNeighbor(featuresTrain, labelsTrain, featuresTest, labelsTest)
%% Create the kNN classifier
knn = ClassificationKNN.fit(featuresTrain, labelsTrain,...
    'NumNeighbors',11,'BreakTies','nearest');

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
% Final baseline score: % 0.6000918 left and % 0.5956482 right

% Create Confusion Matrix
conf = confusionmat(labelsTest, predictedLetter);
% Normalizing to the amount of each test letter
nConfkNN = conf./(sum(conf,2)*ones(1,m));
save('nConfkNN','nConfkNN');
end

function optimalK=kNNValidateK(featuresValid, labelsValid, featuresTest, labelsTest)
%% Validation [NumNeighbours Prediction], 10% validation data
% Set number of k values to test
k_max = 20;

% Best overall: k = 11

%% Left results
% valid = [
%  1 0.5831;  2 0.5799;  3 0.5895;  4 0.5946; 
%  5 0.6042;  6 0.6019;  7 0.6056;  8 0.6024; 
%  9 0.6042; 10 0.6028; 11 0.6070; 12 0.6051;
% 13 0.6038; 14 0.6084; 15 0.6015; 16 0.6028;
% 17 0.6000; 18 0.6024; 19 0.5996; 20 0.6006
% ]
% Best: k = 14 Nearest Neigbors with % 0.60836

%% Right results
% valid = [
%  1 0.5712;  2 0.5707;  3 0.5725;  4 0.5766; 
%  5 0.5743;  6 0.5825;  7 0.5852;  8 0.5866; 
%  9 0.5852; 10 0.5879; 11 0.5879; 12 0.5884;
% 13 0.5852; 14 0.5861; 15 0.5839; 16 0.5834;
% 17 0.5798; 18 0.5811; 19 0.5807; 20 0.5825
% ]
% Best: k = 12 Nearest Neigbors with % 0.5884

%% Algorithm

% Loop through kNN varying k from 1 to 20
kNNscore = zeros(k_max,1);
for k=1:k_max
    % Create the kNN classifier
    knn = ClassificationKNN.fit(featuresValid, labelsValid,...
        'NumNeighbors',k,'BreakTies','nearest');
    % Test on remaining data
    predictedLetter = knn.predict(featuresTest);
    % Establish prediction overview 1 - 57 classes (classes are 32-57)
    m = max(labelsValid);
    [n d] = size(featuresTest);
    vote=zeros(n,m);
    for i=1:n
        vote(i,predictedLetter(i))=1;
    end
    % Calc and print correctness with corresponding k
    k
    kNNscore(k) = sum(predictedLetter==labelsTest)/n % Print % score
end

[highest_performance, optimalK] = max(kNNscore)

end