function [...
    features_train, labels_train, ...
    features_test, labels_test, ...
    features_validation, labels_validation,...
    features_left_train, labels_left_train, ...
    features_left_test, labels_left_test, ...
    features_left_validation, labels_left_validation,...
    features_right_train, labels_right_train, ...
    features_right_test, labels_right_test, ...
    features_right_validation, labels_right_validation...
    ] = skodaRetrieveTrainingTestValidationData

%% Establish training and test data

% Training data: 80% and Test data: 20%
train_factor = 0.8;
% Load data
load('_data_procd')

%% Both
[n,d] = size(features_all_processed);

% Training data
features_train = features_all_processed(1:floor(n*train_factor),:);
labels_train = labels_all_processed(1:floor(n*train_factor),:);
% Test data
features_test = features_all_processed((floor(n*train_factor)+1):end,:);
labels_test = labels_all_processed((floor(n*train_factor)+1):end,:);

% Alternative stepwise method:
%
% % Allocate memory
% features_train = zeros(n*train_factor, d);
% labels_train = zeros(n*train_factor,1);
% features_test = zeros(n*(1-train_factor),d);
% labels_test = zeros(n*(1-train_factor),1);
% % Parameters
% train_test_factor = 4;
% train_test_divident = 5;
% test_train_factor = train_test_divident - train_test_factor;
% trav = 1;
% trav_train = 1;
% trav_test = 1;
% while((trav+train_test_factor) <= n)
%     % Update spans
%     proceed_data = trav + train_test_factor;
%     proceed_train = trav_train + train_test_factor;
%     proceed_test = trav_test + test_train_factor;    
%     % Add new data to feature matrices
%     features_train(trav_train:(proceed_train-1), ...
%         :) = features_all_processed(trav:(proceed_data-1), :);
%     labels_train(trav_train:(proceed_train-1)) = labels_all_processed(trav:(proceed_data-1),1);
%     features_test(trav_test:(proceed_test-1), ...
%         :) = features_all_processed(proceed_data:(proceed_data+test_train_factor-1), :);
%     labels_test(trav_test:(proceed_test-1)) = labels_all_processed(proceed_data:(proceed_data+test_train_factor-1),1);
%     % Update indexing
%     trav_train = proceed_train;
%     trav_test = proceed_test;
%     trav = trav + train_test_divident;
% end

%% Left
[n,d] = size(features_left_processed);

% Training data
features_left_train = features_left_processed(1:floor(n*train_factor),:);
labels_left_train = labels_left_processed(1:floor(n*train_factor),:);
% Test data
features_left_test = features_left_processed((floor(n*train_factor)+1):end,:);
labels_left_test = labels_left_processed((floor(n*train_factor)+1):end,:);

%% Right
[n,d] = size(features_right_processed);

% Training data
features_right_train = features_right_processed(1:floor(n*train_factor),:);
labels_right_train = labels_right_processed(1:floor(n*train_factor),:);
% Test data
features_right_test = features_right_processed((floor(n*train_factor)+1):end,:);
labels_right_test = labels_right_processed((floor(n*train_factor)+1):end,:);

%% Establish validation data

% Parameters: Validation data: 10%
train_valid_factor = 9;
train_valid_divident = 10;
valid_train_factor = train_valid_divident - train_valid_factor;
% Allocate memory
% anti_valid_factor = 0.9;
% [n,d] = size(features_all_processed);
% features_validation = zeros(n*(1-anti_valid_factor),d);
% labels_validation = zeros(n*(1-anti_valid_factor),1);

%% Both
trav = 1;
trav_valid = 1;
while((trav+train_valid_factor) <= length(labels_all_processed))
    % Update spans
    proceed_data = trav + train_valid_factor;
    proceed_valid = trav_valid + valid_train_factor;    
    % Add new data to feature matrices
    features_validation(trav_valid:(proceed_valid-1),:) = features_all_processed(...
        proceed_data:(proceed_data+valid_train_factor-1), :);
    labels_validation(trav_valid:(proceed_valid-1),1) = labels_all_processed(...
        proceed_data:(proceed_data+valid_train_factor-1),1);
    % Update indexing
    trav_valid = proceed_valid;
    trav = trav + train_valid_divident;
end
%% Left
trav = 1;
trav_valid = 1;
while((trav+train_valid_factor) <= length(labels_left_processed))
    % Update spans
    proceed_data = trav + train_valid_factor;
    proceed_valid = trav_valid + valid_train_factor;    
    % Add new data to feature matrices
    features_left_validation(trav_valid:(proceed_valid-1),:) = features_left_processed(...
        proceed_data:(proceed_data+valid_train_factor-1), :);
    labels_left_validation(trav_valid:(proceed_valid-1),1) = labels_left_processed(...
        proceed_data:(proceed_data+valid_train_factor-1),1);
    % Update indexing
    trav_valid = proceed_valid;
    trav = trav + train_valid_divident;
end
%% Right
trav = 1;
trav_valid = 1;
while((trav+train_valid_factor) <= length(labels_right_processed))
    % Update spans
    proceed_data = trav + train_valid_factor;
    proceed_valid = trav_valid + valid_train_factor;    
    % Add new data to feature matrices
    features_right_validation(trav_valid:(proceed_valid-1),:) = features_right_processed(...
        proceed_data:(proceed_data+valid_train_factor-1), :);
    labels_right_validation(trav_valid:(proceed_valid-1),1) = labels_right_processed(...
        proceed_data:(proceed_data+valid_train_factor-1),1);
    % Update indexing
    trav_valid = proceed_valid;
    trav = trav + train_valid_divident;
end

end