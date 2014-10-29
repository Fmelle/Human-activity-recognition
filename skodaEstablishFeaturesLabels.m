function skodaEstablishFeaturesLabels

%% Retrieve calibrated measures

% Load original left arm data
load('left_classall_clean')
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
save('features_left', 'features_left')
save('labels_left', 'labels_left')

% Load original right arm data
load('right_classall_clean')
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
save('features_right', 'features_right')
save('labels_right', 'labels_right')

end