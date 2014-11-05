function [features_all_proces, labels_all_proces] = skodaPreProcessData

%% Preprocess data with sliding window
% 64 unit window length and 50% overflow, label set by median value
window = 64;
overfl = 32;
% Load data
load('_data_raw')

%% Extract mean and standard deviation

index = 1;
j = 1;
while (index + overfl < length(labels_both))
    if(index == 1)
        feat_slide(j,:) = [mean(features_both(index:window,:)) ...
            std(features_both(index:window,:))];
        label_slide(j,1) = labels_both(overfl);
    else
        startInd = index - overfl;
        stopInd = startInd + window;
        feat_slide(j,:) = [mean(features_both(startInd:stopInd,:)) ...
            std(features_both(startInd:stopInd,:))];
        label_slide(j,1) = labels_both(index);
    end
    index = index + window;
    j = j + 1;
end


%% Randomize data

% Establish processed data set with normalized labels
data_processed = [normalizeLabels(label_slide) feat_slide];
% Randomize processed data
data_processed_random = data_processed(randperm(size(data_processed,1)),:);
% Divide randomized data into labels and features
labels_all_proces = data_processed_random(:,1);
features_all_proces = data_processed_random(:,2:end);

save('_data_procd', 'features_all_proces', 'labels_all_proces')

end

function stdLabels=normalizeLabels(labels)
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