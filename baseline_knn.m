function baseline_knn
%% Train and retrieve result of a 10-fold kNearestNeighbor classifier

% Load data
load('EstablishedDataForBaseline/_data_procd__basis')

% Set parameter based on validation results
k = 5; 
% This was overall the optimal k for left, right and both respectively

%% Both
% Find best value of parameter k (Results yield k = 5)
%[optimalK_both, kNNscore_both, rloss_both, kloss_both] = kNNValidateK(...
%    features_all_processed, labels_all_processed);
%save('valid_data_both', ...
%    'optimalK_both', 'kNNscore_both', 'rloss_both', 'kloss_both');

% Perform training and classification
nConfkNN_both = kNearestNeighbor(features_all_processed, ...
    labels_all_processed, k);
% Save and print confusion matrix
% save('nConfkNN_both','nConfkNN_both');
% printConfMat(nConfkNN_both)

%% Left
% Find best value of parameter k (Results yield k = 3)
%[optimalK_left, kNNscore_left, rloss_left, kloss_left] = kNNValidateK(...
%    features_left_processed, labels_left_processed);
%save('valid_data_left', ...
%    'optimalK_left', 'kNNscore_left', 'rloss_left', 'kloss_left');

% Perform training and classification
nConfkNN_left = kNearestNeighbor(features_left_processed, ...
    labels_left_processed, k);
% Save and print confusion matrix
% save('nConfkNN_left','nConfkNN_left');
% printConfMat(nConfkNN_left)

%% Right
% Find best value of parameter k (Results yield k = 3)
%[optimalK_right, kNNscore_right, rloss_right, kloss_right] = kNNValidateK(...
%    features_right_processed, labels_right_processed);
%save('valid_data_right', ...
%    'optimalK_right', 'kNNscore_right', 'rloss_right', 'kloss_right');

% Perform training and classification
nConfkNN_right = kNearestNeighbor(features_right_processed, ...
    labels_right_processed, k);
% Save and print confusion matrix
% save('nConfkNN_right','nConfkNN_right');
% printConfMat(nConfkNN_right)

%% Test on post feature selection data

% Load data to test
%load('right_pca.data')                  % k: 3 Result: 0.868763502989499
%load('left_pca.data')                   % k: 3 Result: 0.905278711912769
%load('right_preprocessed.data')         % k: 3 Result: 0.879163945133899
%load('left_preprocessed.data')          % k: 3 Result: 0.910323040864160
%load('right_lda.data')                  % k: 7 Result: 0.944581218911722
%load('left_lda.data')                   % k: 7 Result: 0.953480077448283

% Execution
%features = data(:,2:end); % Data should be changed to corresponding above
%labels = skodaNormalizeLabels(data(:,1));
%kNNValidateK(features, labels);
%kNearestNeighbor(features, labels, optimalK_from_kNNValidateK_Analysis);

%% Establish results based on 10%, 20%, .., 90%, 100% data



end


function nConfkNN=kNearestNeighbor(features, labels, optimalK)
%% Create and score the kNN classifier
% Create the kNN classifier on all data
knn = ClassificationKNN.fit(features, labels, 'NumNeighbors', optimalK);
% Resubstitution Loss
resubLoss(knn)

% Current resubstitution loss:
% Both:     0.042620509957186
% Left:     0.053902662993582
% Right:    0.064913871260204

% Cross validation 10-fold - Predict on all data
cvknn = crossval(knn, 'KFold', 10);
kfoldLoss(cvknn)

% Current kfold error rate:
% Both:     0.058812581425637
% Left:     0.079981634527103
% Right:    0.092203082502274

predictedLetter = kfoldPredict(cvknn);
% Setup vote matrixs
m = max(labels);
n = size(labels, 1);
vote=zeros(n,m);
for i=1:n
    vote(i,predictedLetter(i))=1;
end
% Calc and Post correctness percentage
sum(predictedLetter==labels)/n % Print % score

% Current score: 
% Both:     0.941187418574353
% Left:     0.920018365472911
% Right:    0.907796917497734

% Create Confusion Matrix
conf = confusionmat(labels, predictedLetter);
% Normalizing to the amount of each test letter
nConfkNN = conf./(sum(conf,2)*ones(1,m));

end

function [optimalK, kNNscore, rloss, kloss]=kNNValidateK(features, labels)
%% Validation [NumNeighbours Prediction], 10-Fold Cross-Validation
% Loop through kNN varying k from 1 to k_max to determine optimal k

% Allocate
k_max = 10;
rloss = zeros(k_max,1);
kloss = zeros(k_max,1);
kNNscore = zeros(k_max,1);
for k=1:k_max
    % Create the kNN classifier
    knn = ClassificationKNN.fit(features, labels, 'NumNeighbors', k);
    % Resubstitution Loss
    rloss(k) = resubLoss(knn);
    % Cross validation
    cvknn = crossval(knn, 'KFold', 10);
    kloss(k) = kfoldLoss(cvknn);
    predictedLetter = kfoldPredict(cvknn);
    % Establish prediction overview
    m = max(labels);
    n = size(labels,1);
    vote=zeros(n,m);
    for i=1:n
        vote(i,predictedLetter(i))=1;
    end
    % Calc and print correctness with corresponding k
    kNNscore(k) = sum(predictedLetter==labels)/n; % Print % score
end
% Plot results
figure
plot(kNNscore)
figure
plot(rloss);
figure
plot(kloss)
% Print results
[highest_performance, optimalK] = max(kNNscore)
[lowest_resub_error, optimalK] = min(rloss)
[lowest_kfold_error, optimalK] = min(kloss)

end

function confmat = printConfMat(nConfkNN)
%% Print confusion matrix for per activity evaluation
% Set original labels
printLabels = '32 49 50 51 52 53 54 55 56 57 58';
% Print confusion matrix
confmat = printmat(nConfkNN, 'Confusion matrix', printLabels, printLabels)

end
