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
        label_slide(j) = labels_both(overfl);
    else
        startInd = index - overfl;
        stopInd = startInd + window;
        feat_slide(j,:) = [mean(features_both(startInd:stopInd,:)) ...
            std(features_both(startInd:stopInd,:))];
        label_slide(j) = labels_both(index);
    end
    index = index + window;
    j = j + 1;
end

features_proc = feat_slide;
labels_proc = label_slide';

save('features_proc', 'features_proc')
save('labels_proc', 'labels_proc')

end