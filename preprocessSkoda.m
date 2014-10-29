function preprocessSkoda

%% Retrieve calibrated measures

% Load original left arm data
load('left_classall_clean')
[n_left d] = size(left_classall_clean);
labels_left = left_classall_clean(:,1);
classall = left_classall_clean(:,2:d);
% Define initial vectors
left_cal = labels_left;
features_left = left_cal;
% Loop through all ten sensor and retrieve only calibrated data
cal_values = 3;
sensor_values = 7;
sensors = (d-1)/sensor_values;
for i=1:sensors
    index = 1 + (i-1)*sensor_values;
    index_end = index + cal_values;
    features_left = [features_left classall(:,(index+1):index_end)];
    left_cal = [left_cal classall(:,index:index_end)];
end
features_left = features_left(:,2:(cal_values*sensors + 1));

% Load original right arm data
load('right_classall_clean')
[n_right d] = size(right_classall_clean);
labels_right = right_classall_clean(:,1);
classall = right_classall_clean(:,2:d);
% Define initial vectors
right_cal = labels_right;
features_right = right_cal;
% Loop through all sensors and retrieve only calibrated data
cal_values = 3;
sensor_values = 7;
sensors = (d-1)/sensor_values;
for i=1:sensors
    index = 1 + (i-1)*sensor_values;
    index_end = index + cal_values;
    features_right = [features_right classall(:,(index+1):index_end)];
    right_cal = [right_cal classall(:,index:index_end)];
end
features_right = features_right(:,2:(cal_values*sensors + 1));

%% Establish training data

% Training data: 80% and Test data: 20%
train_factor = 4/5;
features_left_train = features_left(1:(n_left*train_factor),:);
labels_left_train = labels_left(1:(n_left*train_factor));
save('features_left_train', 'features_left_train')
save('labels_left_train', 'labels_left_train')
features_right_train = features_right(1:(n_right*train_factor),:);
labels_right_train = labels_right(1:(n_right*train_factor));
save('features_right_train', 'features_right_train')
save('labels_right_train', 'labels_right_train')

%% Preprocess test data with sliding window
% 64 unit window length and 50% overflow, label set by median value
window = 64;
overfl = 32;

%% Left
% Establish initial test data
features_left_test_unproc = features_left(...
    ((n_left*train_factor)+1):n_left,:);
labels_left_test_unproc = labels_left(...
    ((n_left*train_factor)+1):n_left);

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
% Establish initial test data
features_right_test_unproc = features_right(...
    ((n_right*train_factor)+1):n_right,:);
labels_right_test_unproc = labels_right(...
    ((n_right*train_factor)+1):n_right);

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