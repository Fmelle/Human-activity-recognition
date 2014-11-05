% 18-697: Statistical Discovery and Learning
% ------------------------------------------
% Project: Generate pre-processed data set
%
% Operations include:
%   - Retrieve Measures for Feature Generation
%   - Feature extraction: Mean and Std Deviation
%   - Generate Training and Testing Data Set
%   - Generate Validation Data Set for Parameter Evaluation

clear all
close all
clc

% Extract unprocessed features and labels and merge both original data sets
skodaEstablishFeaturesLabels();
% Pre-process data with feature extraction and randomization
skodaPreProcessData();
% Retrieve training, test and validation data
skodaRetrieveTrainingTestValidationData();

% ALWAYS RUN THIS FILE TO GENERATE NEW DATASET
