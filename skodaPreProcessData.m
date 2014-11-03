function skodaPreProcessData

%% Preprocess data with sliding window
% 64 unit window length and 50% overflow, label set by median value
window = 64;
overfl = 32;
% Load data
load('features_left')
load('labels_left')
load('features_right')
load('labels_right')

%% Left
index_left = 1;
j = 1;
while (index_left + overfl < length(labels_left))
    if(index_left == 1)
        feat_slide_left(j,:) = mean(features_left(...
            index_left:window,:));
        label_slide_left(j) = labels_left(overfl);
    else
        startInd = index_left - overfl;
        stopInd = startInd + window;
        feat_slide_left(j,:) = mean(features_left(...
            startInd:stopInd,:));
        label_slide_left(j) = labels_left(index_left);
    end
    index_left = index_left + window;
    j = j + 1;
end

features_left_proc = feat_slide_left;
labels_left_proc = label_slide_left';

save('features_left_proc', 'features_left_proc')
save('labels_left_proc', 'labels_left_proc')

%% Right
index_right = 1;
k = 1;
while (index_right + overfl < length(labels_right))
    if(index_right == 1)
        feat_slide_right(k,:) = mean(features_right(...
            index_right:window,:));
        label_slide_right(k) = labels_right(overfl);
    else
        startInd = index_right - overfl;
        stopInd = startInd + window;
        feat_slide_right(k,:) = mean(features_right(...
            startInd:stopInd,:));
        label_slide_right(k) = labels_right(index_right);
    end
    index_right = index_right + window;
    k = k + 1;
end

features_right_proc = feat_slide_right;
labels_right_proc = label_slide_right';

save('features_right_proc', 'features_right_proc')
save('labels_right_proc', 'labels_right_proc')

end