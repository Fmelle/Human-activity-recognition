% 18-697: Statistical Discovery and Learning
% ------------------------------------------
% Project: Generate pre-processed data set
%
% Operations include:
%   - Retrieve Measures for Feature Generation
%   - Feature extraction: Mean and Std Deviation
%   - Generate Training and Testing Data Set
%   - Generate Validation Data Set for Parameter Evaluation
%

clear all
close all
clc
addpath(genpath(pwd));

%% Load original separated and unprocessed sensor data
load('left_classall_clean')
load('right_classall_clean')

%% Extract unprocessed features and labels and merge both original data sets
[features_both, labels_both...
    ] = skodaEstablishFeaturesLabels(left_classall_clean, right_classall_clean);
%% Pre-process data with feature extraction and randomization
[features_all_proces, labels_all_proces] = skodaPreProcessData();
%% Retrieve training, test and validation data - save results
[features_train, labels_train, ...
    features_test, labels_test, ...
    features_validation, labels_validation...
    ] = skodaRetrieveTrainingTestValidationData();

save('data_ready', 'features_train', 'labels_train', 'features_test', ...
    'labels_test', 'features_validation', 'labels_validation');

% ALWAYS RUN THIS FILE TO GENERATE NEW DATASET
