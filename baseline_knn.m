function baseline_knn
%% Train and retrieve result of kNearestNeighbor

% Load data
load('data_procd_split__basis')

%% Both
% Find best value of parameter k
%k_max = 30;
%optimalK = kNNValidateK(features_validation, ...
%    labels_validation, features_test, labels_test, k_max);

% Chosen k based on validation data results
k = 6;
% Perform training and classification
voteKNN = kNearestNeighbor(features_train, ... 
    labels_train, features_test, labels_test, k);
%% Left
% Find best value of parameter k
k_max = 30;
optimalK = kNNValidateK(features_left_validation, ...
    labels_left_validation, features_left_test, labels_left_test, k_max);

% Chosen k based on validation data results
k = 3;
% Perform training and classification
voteKNN = kNearestNeighbor(features_left_train, ... 
    labels_left_train, features_left_test, labels_left_test, k);

%% Right
% Find best value of parameter k
k_max = 30;
optimalK = kNNValidateK(features_right_validation, ...
    labels_right_validation, features_right_test, labels_right_test, k_max);

% Chosen k based on validation data results
k = 6;
% Perform training and classification
voteKNN = kNearestNeighbor(features_right_train, ... 
    labels_right_train, features_right_test, labels_right_test, k);

end


function vote=kNearestNeighbor(featuresTrain, labelsTrain, featuresTest, labelsTest, optimalK)
%% Create and score the kNN classifier
knn = ClassificationKNN.fit(featuresTrain, labelsTrain,...
    'NumNeighbors',optimalK,'BreakTies','nearest');

% Test on remaining data
predictedLetter = knn.predict(featuresTest);
% Establish prediction
m = max(labelsTrain);
[n d] = size(featuresTest);
vote=zeros(n,m);
for i=1:n
    vote(i,predictedLetter(i))=1;
end
% Calc and Post correctness percentage
sum(predictedLetter==labelsTest)/n % Print % score

% Current score: 
% Both:     0.941860465116279
% Left:     0.915977961432507
% Right:    0.907978241160471

% Create Confusion Matrix
conf = confusionmat(labelsTest, predictedLetter);
% Normalizing to the amount of each test letter
nConfkNN = conf./(sum(conf,2)*ones(1,m));
save('nConfkNN','nConfkNN');
% Print confusion matrix
labels = '32 49 50 51 52 53 54 55 56 57 58';
printmat(nConfkNN, 'Confusion matrix', labels, labels)
end

function optimalK=kNNValidateK(featuresValid, labelsValid, featuresTest, labelsTest, k_max)
%% Validation [NumNeighbours Prediction], 10% validation data
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

% Plot results
figure
plot(kNNscore)
% Print results
kNNscore
[highest_performance, optimalK] = max(kNNscore)

end