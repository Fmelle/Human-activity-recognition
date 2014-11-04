function skodaRetrieveTrainingTestData

%% Establish training and test data

% Training data: 80% and Test data: 20%
train_factor = 0.8;
train_test_factor = 4;
train_test_divident = 5;
test_train_factor = train_test_divident - train_test_factor;
% Load data
load('features_all_proces')
load('labels_all_proces')
[n,d] = size(features_all_proces);
% Allocate memory
features_train = zeros(n*train_factor, d);
labels_train = zeros(n*train_factor,1);
features_test = zeros(n*(1-train_factor),d);
labels_test = zeros(n*(1-train_factor),1);
trav = 1;
trav_train = 1;
trav_test = 1;
while((trav+train_test_factor) <= length(features_all_proces))
    % Update spans
    proceed_data = trav + train_test_factor;
    proceed_train = trav_train + train_test_factor;
    proceed_test = trav_test + test_train_factor;    
    % Add new data to feature matrices
    features_train(trav_train:(proceed_train-1), ...
        :) = features_all_proces(trav:(proceed_data-1), :);
    labels_train(trav_train:(proceed_train-1)) = normalizeLabel(...
        labels_all_proces(trav:(proceed_data-1),1));
    features_test(trav_test:(proceed_test-1), ...
        :) = features_all_proces(proceed_data:(proceed_data+test_train_factor-1), :);
    labels_test(trav_test:(proceed_test-1)) = normalizeLabel(...
        labels_all_proces(proceed_data:(proceed_data+test_train_factor-1),1));
    % Update indexing
    trav_train = proceed_train;
    trav_test = proceed_test;
    trav = trav + train_test_divident;
end

save('features_train', 'features_train')
save('labels_train', 'labels_train')
save('features_test', 'features_test')
save('labels_test', 'labels_test')

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