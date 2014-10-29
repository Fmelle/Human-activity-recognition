function skodaPreProcessTestData

%% Preprocess test data with sliding window
% 64 unit window length and 50% overflow, label set by median value
window = 64;
overfl = 32;
% Load data
load('features_left_test_unproc')
load('labels_left_test_unproc')
load('features_right_test_unproc')
load('labels_right_test_unproc')

%% Left
index_left = 1;
j = 1;
while (index_left + overfl < length(labels_left_test_unproc))
    if(index_left == 1)
        feat_slide_left(j,:) = mean(features_left_test_unproc(...
            index_left:window,:));
        label_slide_left(j) = labels_left_test_unproc(overfl);
    else
        startInd = index_left - overfl;
        stopInd = startInd + window;
        feat_slide_left(j,:) = mean(features_left_test_unproc(...
            startInd:stopInd,:));
        label_slide_left(j) = labels_left_test_unproc(index_left);
    end
    index_left = index_left + window;
    j = j + 1;
end

features_left_test = feat_slide_left;
labels_left_test = label_slide_left';

save('features_left_test', 'features_left_test')
save('labels_left_test', 'labels_left_test')

%% Right
index_right = 1;
k = 1;
while (index_right + overfl < length(labels_right_test_unproc))
    if(index_right == 1)
        feat_slide_right(k,:) = mean(features_right_test_unproc(...
            index_right:window,:));
        label_slide_right(k) = labels_right_test_unproc(overfl);
    else
        startInd = index_right - overfl;
        stopInd = startInd + window;
        feat_slide_right(k,:) = mean(features_right_test_unproc(...
            startInd:stopInd,:));
        label_slide_right(k) = labels_right_test_unproc(index_right);
    end
    index_right = index_right + window;
    k = k + 1;
end

features_right_test = feat_slide_right;
labels_right_test = label_slide_right';

save('features_right_test', 'features_right_test')
save('labels_right_test', 'labels_right_test')

end