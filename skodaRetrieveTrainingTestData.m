function skodaRetrieveTrainingTestData

%% Establish training and test data

% Training data: 80% and Test data: 20%
train_factor = 0.8;
train_test_factor = 4;
train_test_divident = 5;
test_train_factor = train_test_divident - train_test_factor;
%% Left
% Load data
load('features_left_proc')
load('labels_left_proc')
[n_left,d] = size(features_left_proc);
% Allocate memory
features_left_train = zeros(n_left*train_factor, d);
labels_left_train = zeros(n_left*train_factor,1);
features_left_test = zeros(n_left*(1-train_factor),d);
labels_left_test = zeros(n_left*(1-train_factor),1);
trav_left = 1;
trav_train = 1;
trav_test = 1;
while((trav_left+train_test_factor) <= length(features_left_proc))
    % Update spans
    proceed_data = trav_left + train_test_factor;
    proceed_train = trav_train + train_test_factor;
    proceed_test = trav_test + test_train_factor;    
    % Add new data to feature matrices
    features_left_train(trav_train:(proceed_train-1), ...
        :) = features_left_proc(trav_left:(proceed_data-1), :);
    labels_left_train(trav_train:(proceed_train-1)) = normalizeLabel(...
        labels_left_proc(trav_left:(proceed_data-1)));
    features_left_test(trav_test:(proceed_test-1), ...
        :) = features_left_proc(proceed_data:(proceed_data+test_train_factor-1), :);
    labels_left_test(trav_test:(proceed_test-1)) = normalizeLabel(...
        labels_left_proc(proceed_data:(proceed_data+test_train_factor-1)));
    % Update indexing
    trav_train = proceed_train;
    trav_test = proceed_test;
    trav_left = trav_left + train_test_divident;
end
% Old straight extraction - data not randomized so extraction iterative
%features_left_train = features_left(1:(n_left*train_factor),:);
%labels_left_train = labels_left(1:(n_left*train_factor));
%features_left_test_unproc = features_left(...
%    ((n_left*train_factor)+1):n_left,:);
%labels_left_test_unproc = labels_left(...
%    ((n_left*train_factor)+1):n_left);
save('features_left_train', 'features_left_train')
save('labels_left_train', 'labels_left_train')
save('features_left_test', 'features_left_test')
save('labels_left_test', 'labels_left_test')

%% Right
% Load data
load('features_right_proc')
load('labels_right_proc')
[n_right,d] = size(features_right_proc);
% Allocate Memory
features_right_train = zeros(n_right*train_factor,d);
labels_right_train = zeros(n_right*train_factor,1);
features_right_test = zeros(n_right*(1-train_factor),d);
labels_right_test = zeros(n_right*(1-train_factor),1);
trav_right = 1;
trav_train = 1;
trav_test = 1;
while((trav_right+train_test_factor) <= length(features_right_proc))
    % Update spans
    proceed_data = trav_right + train_test_factor;
    proceed_train = trav_train + train_test_factor;
    proceed_test = trav_test + test_train_factor;
    % Add new data to feature matrices
    features_right_train(trav_train:(proceed_train-1), ...
        :) = features_right_proc(trav_right:(proceed_data-1), :);
    labels_right_train(trav_train:(proceed_train-1)) = normalizeLabel(...
        labels_right_proc(trav_right:(proceed_data-1)));
    features_right_test(trav_test:(proceed_test-1), ...
        :) = features_right_proc(proceed_data:(proceed_data+test_train_factor-1), :);
    labels_right_test(trav_test:(proceed_test-1)) = normalizeLabel(...
        labels_right_proc(proceed_data:(proceed_data+test_train_factor-1)));
    % Update indexing
    trav_train = proceed_train;
    trav_test = proceed_test;
    trav_right = trav_right + train_test_divident;
end
% Old straight extraction - data not randomized so extraction iterative
%features_right_train = features_right(1:(n_right*train_factor),:);
%labels_right_train = labels_right(1:(n_right*train_factor));
%features_right_test_unproc = features_right(...
%    ((n_right*train_factor)+1):n_right,:);
%labels_right_test_unproc = labels_right(...
%    ((n_right*train_factor)+1):n_right);
save('features_right_train', 'features_right_train')
save('labels_right_train', 'labels_right_train')
save('features_right_test', 'features_right_test')
save('labels_right_test', 'labels_right_test')

end

function stdLabels=normalizeLabel(labels)
% Replace a given skoda activity label with normalized value
stdLabels = labels;
for i=1:length(labels)
    switch labels(i,1)
        case 32
            stdLabels(i,1) = 1;
        case 48
            stdLabels(i,1) = 2;
        case 49
            stdLabels(i,1) = 3;
        case 50
            stdLabels(i,1) = 4;
        case 51
            stdLabels(i,1) = 5;
        case 52
            stdLabels(i,1) = 6;
        case 53
            stdLabels(i,1) = 7;
        case 54
            stdLabels(i,1) = 8;
        case 55
            stdLabels(i,1) = 9;
        case 56
            stdLabels(i,1) = 10;
        case 57
            stdLabels(i,1) = 11;
        otherwise
            disp('unknown label encountered');
    end
end
end