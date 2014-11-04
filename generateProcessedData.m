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

skodaEstablishFeaturesLabels();
skodaPreProcessData();
skodaRetrieveTrainingTestData();
skodaRetrieveValidationData();

% ALWAYS RUN THIS FILE TO GENERATE NEW DATASET