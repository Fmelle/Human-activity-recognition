% 18-697: Statistical Discovery and Learning
% ------------------------------------------
% Project: Generate pre-processed data set
%
% Operations include:
%   - Retrieve Measures for Feature Generation
%   - Feature extraction: Mean and Variance
%   - Generate Training and Testing Data Set
%   - Generate Validation Data Set for Parameter Evaluation

clear all
close all
clc

% Extract unprocessed features and labels and merge both original data sets
skodaEstablishFeaturesLabels();
delete('features_left.mat')
delete('labels_left.mat')
delete('features_right.mat')
delete('labels_right.mat')
% Pre-process data with feature extraction and randomization
skodaPreProcessData();
delete('features_both.mat')
delete('labels_both.mat')
% Retrieve training - test - validation data
skodaRetrieveTrainingTestData();
skodaRetrieveValidationData();

% ALWAYS RUN THIS FILE TO GENERATE NEW DATASET