function skodaPreProcessData

%% Preprocess data with sliding window
% 64 unit window length and 50% overflow, label set by median value
window = 64;
overfl = 32;
% Load data
load('features_both')
load('labels_both')

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

% Establish processed data set
data_processed = [label_slide feat_slide];
% Randomize processed data
data_processed_random = data_processed(randperm(size(data_processed,1)),:);
% Divide into labels and features
labels_all_proces = data_processed_random(:,1);
features_all_proces = data_processed_random(:,2:end);

save('features_all_proces', 'features_all_proces')
save('labels_all_proces', 'labels_all_proces')

end