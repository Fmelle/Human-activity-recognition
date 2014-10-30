function skodaRetrieveValidationData

%% Establish validation data

% Validation data: 10%
anti_valid_factor = 0.9;
train_valid_factor = 9;
train_valid_divident = 10;
valid_train_factor = train_valid_divident - train_valid_factor;
%% Left
% Load data
load('features_left')
load('labels_left')
[n_left,d] = size(features_left);
% Allocate memory
features_left_valid = zeros(n_left*(1-anti_valid_factor),d);
labels_left_valid = zeros(n_left*(1-anti_valid_factor),1);
trav_left = 1;
trav_valid = 1;
while((trav_left+train_valid_factor) <= length(features_left))
    % Update spans
    proceed_data = trav_left + train_valid_factor;
    proceed_valid = trav_valid + valid_train_factor;    
    % Add new data to feature matrices
    features_left_valid(trav_valid:(proceed_valid-1), ...
        :) = features_left(proceed_data:(proceed_data+valid_train_factor-1), :);
    labels_left_valid(trav_valid:(proceed_valid-1)) = normalizeLabel(...
        labels_left(proceed_data:(proceed_data+valid_train_factor-1)));
    % Update indexing
    trav_valid = proceed_valid;
    trav_left = trav_left + train_valid_divident;
end

save('features_left_valid', 'features_left_valid')
save('labels_left_valid', 'labels_left_valid')

%% Right
% Load data
load('features_right')
load('labels_right')
[n_right,d] = size(features_right);
% Allocate Memory
features_right_valid = zeros(n_right*(1-anti_valid_factor),d);
labels_right_valid = zeros(n_right*(1-anti_valid_factor),1);
trav_right = 1;
trav_valid = 1;
while((trav_right+train_valid_factor) <= length(features_right))
    % Update spans
    proceed_data = trav_right + train_valid_factor;
    proceed_valid = trav_valid + valid_train_factor;
    % Add new data to feature matrices
    features_right_valid(trav_valid:(proceed_valid-1), ...
        :) = features_right(proceed_data:(proceed_data+valid_train_factor-1), :);
    labels_right_valid(trav_valid:(proceed_valid-1)) = normalizeLabel(...
        labels_right(proceed_data:(proceed_data+valid_train_factor-1)));
    % Update indexing
    trav_valid = proceed_valid;
    trav_right = trav_right + train_valid_divident;
end

save('features_right_valid', 'features_right_valid')
save('labels_right_valid', 'labels_right_valid')

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