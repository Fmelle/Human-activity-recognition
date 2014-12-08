function baseline_knn
%% Train and retrieve result of a 10-fold kNearestNeighbor classifier

% Load data
load('EstablishedDataForBaseline/_data_procd__basis')

%% Both
% Find best value of parameter k (Results yield k = 5)
%[optimalK_both, kNNscore_both, rloss_both, kloss_both] = kNNValidateK(...
%    features_all_processed, labels_all_processed);
%save('valid_data_both', ...
%    'optimalK_both', 'kNNscore_both', 'rloss_both', 'kloss_both');
k = 5;
% Perform training and classification
[nConfkNN_both, score_both, f1_both] = kNearestNeighbor(features_all_processed, ...
    labels_all_processed, k);
% Save and print confusion matrix
disp('Both conf mat')
save('nConfkNN_both','nConfkNN_both');
printConfMat(nConfkNN_both)
figure
surf(nConfkNN_both)
title(['Confusion matrix for Combined dataset'])

%% Left
% Find best value of parameter k (Results yield k = 3)
%[optimalK_left, kNNscore_left, rloss_left, kloss_left] = kNNValidateK(...
%    features_left_processed, labels_left_processed);
%save('valid_data_left', ...
%    'optimalK_left', 'kNNscore_left', 'rloss_left', 'kloss_left');
k = 3;
% Perform training and classification
[nConfkNN_left, score_left, f1_left] = kNearestNeighbor(features_left_processed, ...
    labels_left_processed, k);
% Save and print confusion matrix
disp('Left conf mat')
save('nConfkNN_left','nConfkNN_left');
printConfMat(nConfkNN_left)
figure
surf(nConfkNN_left)
title(['Confusion matrix for Left dataset'])

%% Right
% Find best value of parameter k (Results yield optimal k = 3)
%[optimalK_right, kNNscore_right, rloss_right, kloss_right] = kNNValidateK(...
%    features_right_processed, labels_right_processed);
%save('valid_data_right', ...
%    'optimalK_right', 'kNNscore_right', 'rloss_right', 'kloss_right');
k = 3;
% Perform training and classification
[nConfkNN_right, score_right, f1_right] = kNearestNeighbor(features_right_processed, ...
    labels_right_processed, k);
% Save and print confusion matrix
disp('Right conf mat')
save('nConfkNN_right','nConfkNN_right');
printConfMat(nConfkNN_right)
figure
surf(nConfkNN_right)
title(['Confusion matrix for Right dataset'])

%% Test on post feature selection data

% Load data to test
%load('left_pca.data')                   % k: 3 Result: 0.905278711912769
%load('right_pca.data')                  % k: 3 Result: 0.868763502989499
%load('left_preprocessed.data')          % k: 3 Result: 0.910323040864160
%load('right_preprocessed.data')         % k: 3 Result: 0.879163945133899


load('left_lda.data')  
% k: 7 Result: 0.953480077448283 Loss: 0.046927545093232
k = 7;
% Execution
features = left_lda(:,2:end); % Data should be changed to corresponding above
labels = skodaNormalizeLabels(left_lda(:,1));
% kNNValidateK(features, labels);
[nConfkNN_left_lda, score_left_lda, f1_left_lda] = kNearestNeighbor(features, labels, k);
% Save and print confusion matrix
disp('Left LDA conf mat')
save('nConfkNN_left_lda','nConfkNN_left_lda');
printConfMat(nConfkNN_left_lda)
figure
surf(nConfkNN_left_lda)
title(['Confusion matrix for Left LDA dataset'])

load('right_lda.data') 
% k: 7 Result: 0.944581218911722 Loss: 0.055469024770125
k = 7;
% Execution
features = right_lda(:,2:end); % Data should be changed to corresponding above
labels = skodaNormalizeLabels(right_lda(:,1));
% kNNValidateK(features, labels);
[nConfkNN_right_lda, score_right_lda, f1_right_lda] = kNearestNeighbor(features, labels, k);
% Save and print confusion matrix
disp('Right LDA conf mat')
save('nConfkNN_right_lda','nConfkNN_right_lda');
printConfMat(nConfkNN_right_lda)
figure
surf(nConfkNN_right_lda)
title(['Confusion matrix for Right LDA dataset'])

%% Compare performance

% Improvement right
nConfkNN_right_imp = nConfkNN_right_lda - nConfkNN_right;
disp('Right conf mat improve')
save('nConfkNN_right_imp','nConfkNN_right_imp');
printConfMat(nConfkNN_right_imp)
figure
surf(nConfkNN_right_imp)
title(['nConfkNN right imp'])

% Improvement left
nConfkNN_left_imp = nConfkNN_left_lda - nConfkNN_left;
disp('Left conf mat improve')
save('nConfkNN_left_imp','nConfkNN_left_imp');
printConfMat(nConfkNN_left_imp)
figure
surf(nConfkNN_left_imp)
title(['nConfkNN left imp'])

%% Analyze performance based on 10%, 20%, .., 90%, 100% data

% Both
k = 5;
[score_perc_both, f1_perc_both] = PercentAnalysis(features_all_processed, ... 
    labels_all_processed, k, 10);
figure
plot(score_perc_both)
title(['Score both perc'])
figure
plot(f1_perc_both)
title(['F1 both perc'])
% 10%: Perf 0.846368715083799 Loss 0.153631284916202
% 60%: Perf 0.932371645726695 Loss 0.067628354273311
save('score_perc_both', 'score_perc_both')
save('f1_perc_both', 'f1_perc_both')
% Right
k = 3;
[score_perc_right, f1_perc_right] = PercentAnalysis(features_right_processed, ... 
    labels_right_processed, k, 10);
figure
plot(score_perc_right)
title(['Score right perc'])
figure
plot(f1_perc_right)
title(['F1 right perc'])
% 10%: Perf 0.806890299184044 Loss 0.193109700815951
% 60%: Perf 0.896041100030221 Loss 0.103958899969793
save('score_perc_right', 'score_perc_right')
save('f1_perc_right', 'f1_perc_right')
% Left
k = 3;
[score_perc_left, f1_perc_left]= PercentAnalysis(features_left_processed, ... 
    labels_left_processed, k, 10);
figure
plot(score_perc_left)
title(['Score left perc'])
figure
plot(f1_perc_left)
title(['F1 left perc'])
% 10%: Perf 0.819100091827365 Loss 0.180899908172631
% 60%: Perf 0.903428221610040 Loss 0.096571778389948
% 80%: Perf 0.915289256198347 Loss 0.084710743801644
save('score_perc_left', 'score_perc_left')
save('f1_perc_left', 'f1_perc_left')


end


function [nConfkNN, score, F1]=kNearestNeighbor(features, labels, optimalK)
%% Create and score the kNN classifier
% Create the kNN classifier on all data
knn = ClassificationKNN.fit(features, labels, 'NumNeighbors', optimalK);
% Resubstitution Loss
resubLoss(knn);

% Current resubstitution loss:
% Both:     0.042620509957186
% Left:     0.053902662993582
% Right:    0.064913871260204

% Cross validation 10-fold - Predict on all data
cvknn = crossval(knn, 'KFold', 10);
errorRate = kfoldLoss(cvknn) % Print loss

% Current K-fold error rate:
% Both:     0.058347292015624
% Left:     0.079614325068885
% Right:    0.090480507706263

predictedActivity = kfoldPredict(cvknn);
% Setup vote matrixs
m = max(labels);
n = size(labels, 1);
vote=zeros(n,m);
for i=1:n
    vote(i,predictedActivity(i))=1;
end
% Calc and Post correctness percentage
score = sum(predictedActivity==labels)/n % Print score

% Current score: 
% Both:     0.941652707984366
% Left:     0.920385674931129
% Right:    0.909519492293744

% Collect general performance
perf = classperf(labels, predictedActivity);
sense = perf.Sensitivity;
F1 = 2*((score*sense)/(score+sense)) % Print F1

% Current sensitivity:
% Both:     0.929431299294313
% Left:     0.920225624496374
% Right:    0.898533950617284

% Current F1 score: 
% Both:     0.935502090190829
% Left:     0.920305642755155
% Right:    0.903993347960279

% Create Confusion Matrix
conf = confusionmat(labels, predictedActivity);
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

function printConfMat(nConfkNN)
%% Print confusion matrix for per activity evaluation
% Set original labels
printLabels = '32 48 49 50 51 52 53 54 55 56 57';
% Print confusion matrix
printmat(nConfkNN, 'Confusion matrix', printLabels, printLabels)

end

function [score_perc, f1_perc] = PercentAnalysis(features, labels, k, partitions)
% Set parameters
score_perc = zeros(partitions,1);
f1_perc = zeros(partitions,1);
[splot_dim1,splot_dim2] = getSubPlotDims(partitions);

% Do KNN for each percentage
figure
for i=1:partitions
    [features_perc, labels_perc] = getPercData(features, ...
        labels, i, partitions);
    [nConfkNN_perc, score_perc(i,1), f1_perc(i,1)] = kNearestNeighbor(features_perc, ...
        labels_perc, k);
    % Plot confusion matrices to see evolution of per-acitivty error
    subplot(splot_dim1,splot_dim2,i)
    surf(nConfkNN_perc)
end

end

function [features_perc, labels_perc] = getPercData(features, labels, i, p)
% Get number of rows to extract
perc = floor(length(features)*i*(1/p));
% Get percentage of features and labels
features_perc = features(1:perc,:);
labels_perc = labels(1:perc,1);
end

function [dim1, dim2] = getSubPlotDims(partitions)
% Set the subplot dimentions depending on number of partitions
if(partitions < 17)
    dim2 = 4;
    if(partitions < 13)
        dim1 = 3;
    else
        dim1 = 4;
    end
else
    dim2 = 5;
    if(partitions < 21)
        dim1 = 4;
    else
        dim1 = 5;
    end
end

end
