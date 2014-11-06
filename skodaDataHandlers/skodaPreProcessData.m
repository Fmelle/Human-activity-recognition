function [...
    features_all_processed, labels_all_processed,...
    features_left_processed, labels_left_processed,...
    features_right_processed, labels_right_processed] = skodaPreProcessData

%% Preprocess data with sliding window
% 64 unit window length and 50% overflow, label set by median value
window = 64;
overfl = 32;
% Load data
load('_data_raw')

%% Extract mean and standard deviation

%% Both
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

% Randomize data

% Establish processed data set with normalized labels
data_processedsed = [normalizeLabels(label_slide) feat_slide];
% Randomize processed data
data_processedsed_random = data_processedsed(randperm(size(data_processedsed,1)),:);
% Divide randomized data into labels and features
labels_all_processed = data_processedsed_random(:,1);
features_all_processed = data_processedsed_random(:,2:end);

%% Left
index_left = 1;
j = 1;
while (index_left + overfl < length(labels_left))
    if(index_left == 1)
        feat_left_slide(j,:) = [mean(features_left(index_left:window,:)) ...
            std(features_left(index_left:window,:))];
        label_left_slide(j,1) = labels_left(overfl);
    else
        startInd = index_left - overfl;
        stopInd = startInd + window;
        feat_left_slide(j,:) = [mean(features_left(startInd:stopInd,:)) ...
            std(features_left(startInd:stopInd,:))];
        label_left_slide(j,1) = labels_left(index_left);
    end
    index_left = index_left + window;
    j = j + 1;
end

% Randomize data

% Establish processed data set with normalized labels
data_processedsed = [normalizeLabels(label_left_slide) feat_left_slide];
% Randomize processed data
data_processedsed_random = data_processedsed(randperm(size(data_processedsed,1)),:);
% Divide randomized data into labels and features
labels_left_processed = data_processedsed_random(:,1);
features_left_processed = data_processedsed_random(:,2:end);

%% Right
index_right = 1;
j = 1;
while (index_right + overfl < length(labels_right))
    if(index_right == 1)
        feat_right_slide(j,:) = [mean(features_right(index_right:window,:)) ...
            std(features_right(index_right:window,:))];
        label_right_slide(j,1) = labels_right(overfl);
    else
        startInd = index_right - overfl;
        stopInd = startInd + window;
        feat_right_slide(j,:) = [mean(features_right(startInd:stopInd,:)) ...
            std(features_right(startInd:stopInd,:))];
        label_right_slide(j,1) = labels_right(index_right);
    end
    index_right = index_right + window;
    j = j + 1;
end

% Randomize data

% Establish processed data set with normalized labels
data_processedsed = [normalizeLabels(label_right_slide) feat_right_slide];
% Randomize processed data
data_processedsed_random = data_processedsed(randperm(size(data_processedsed,1)),:);
% Divide randomized data into labels and features
labels_right_processed = data_processedsed_random(:,1);
features_right_processed = data_processedsed_random(:,2:end);

%% Save results

save('_data_procd', ...
    'features_all_processed', 'labels_all_processed',....
    'features_left_processed', 'labels_left_processed',...
    'features_right_processed', 'labels_right_processed')

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