function skodaRetrieveValidationData

%% Establish validation data

% Validation data: 10%
anti_valid_factor = 0.9;
train_valid_factor = 9;
train_valid_divident = 10;
valid_train_factor = train_valid_divident - train_valid_factor;
%% Left
% Load data
load('features_all_proces')
load('labels_all_proces')
[n,d] = size(features_all_proces);
% Allocate memory
features_validation = zeros(n*(1-anti_valid_factor),d);
labels_validation = zeros(n*(1-anti_valid_factor),1);
trav = 1;
trav_valid = 1;
while((trav+train_valid_factor) <= length(features_all_proces))
    % Update spans
    proceed_data = trav + train_valid_factor;
    proceed_valid = trav_valid + valid_train_factor;    
    % Add new data to feature matrices
    features_validation(trav_valid:(proceed_valid-1), ...
        :) = features_all_proces(proceed_data:(proceed_data+valid_train_factor-1), :);
    labels_validation(trav_valid:(proceed_valid-1)) = normalizeLabel(...
        labels_all_proces(proceed_data:(proceed_data+valid_train_factor-1),1));
    % Update indexing
    trav_valid = proceed_valid;
    trav = trav + train_valid_divident;
end

save('features_validation', 'features_validation')
save('labels_validation', 'labels_validation')

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