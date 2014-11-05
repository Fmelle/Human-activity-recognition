function skodaEstablishFeaturesLabels

%% Retrieve measures

%% General parameters

% Calibrated/Raw Data Switch: Set to 3 for RAW, Set to 0 for CALIBRATED
raw = 3;
% If a smaller subset of sensors is preferred;
% Reduce to which sensors (s) to look at in the array (s corresponds to the
% parameter s=0..10 for each arm)
sensors_to_keep_left = [1,2,3,4,5,6,7,8,9,10];
sensors_to_keep_right = [1,2,3,4,5,6,7,8,9,10];

% In iteration #1 only 6 sensors was used:
% left: [1,2,10]
% right: [1,2,7]
% Remark: Sensors cannot be connected to actual measure points and must be
% evaluated without pre-knowledge for eventual excluding some

%% Load original left arm data
load('left_classall_clean')
[n_left,d] = size(left_classall_clean);
labels_left = left_classall_clean(:,1);
classall = left_classall_clean(:,2:d);
% Define initial vectors
left_data = labels_left;
features_left = left_data;
% Loop through all ten sensor and retrieve only calibrated data
nb_values = 3;
sensor_values = 7;
nb_sensors_left = length(sensors_to_keep_left);
sensors = (d-1)/sensor_values;
for i=1:sensors
    if(any(i == sensors_to_keep_left))
        index = 1 + (i-1)*sensor_values + raw;
        index_end = index + nb_values;
        features_left = [features_left classall(:,(index+1):index_end)];
        left_data = [left_data classall(:,index:index_end)];
    end
end
features_left = features_left(:,2:end);
%save('features_left', 'features_left')
%save('labels_left', 'labels_left')

%% Load original right arm data
load('right_classall_clean')
[n_right,d] = size(right_classall_clean);
labels_right = right_classall_clean(:,1);
classall = right_classall_clean(:,2:d);
% Define initial vectors
right_data = labels_right;
features_right = right_data;
% Loop through all sensors and retrieve only calibrated data
nb_values = 3;
sensor_values = 7;
sensors = (d-1)/sensor_values;
nb_sensors_right = length(sensors_to_keep_right);
for i=1:sensors
    if(any(i == sensors_to_keep_right))
        index = 1 + (i-1)*sensor_values + raw;
        index_end = index + nb_values;
        features_right = [features_right classall(:,(index+1):index_end)];
        right_data = [right_data classall(:,index:index_end)];
    end
end
features_right = features_right(:,2:end);
%save('features_right', 'features_right')
%save('labels_right', 'labels_right')

%% Merge data sets

% Assess longest
if(n_right > n_left)
    % Allocate features and labels
    i = 1; k = 1; p = 1;
    [n,d] = size(features_left);
    features_both = zeros(n,d*2);
    labels_both = zeros(n,1);
    % Establish combined data set
    while(k < n_right && i < n_left)
        if(labels_left(i) == labels_right(k))
            labels_both(p,1) = labels_left(i,1);
            features_both(p,:) = [features_left(i,:) features_right(k,:)];
            p = p + 1;
            i = i + 1;
            k = k + 1;
        else
            % If data sets corresponds we search to align them again giving
            % priority to the one who changed activity
            if(labels_left(i) == labels_left(i-1))
                j = i;
                while(labels_left(j) ~= labels_right(k))
                    if(j-i < 5000)
                        j = j + 1;
                    else
                        % If no alignment can be found for recent change
                        % then we will rather skip the activity as it does
                        % appear incoherent in both data sets
                        j = i;
                        while(labels_left(i) ~= labels_right(k))
                            k = k + 1;
                        end
                        break;
                    end
                end
                i = j;
            else 
                j = k;
                while(labels_left(i) ~= labels_right(j))
                    if(j-k < 5000)
                        j = j + 1;
                    else
                        j = k;
                        while(labels_left(i) ~= labels_right(k))
                            i = i + 1;
                        end
                        break;
                    end      
                end          
                k = j;
            end
        end
    end
else
    disp('left arm data set is longer than right arm data set')
end

% Clean out zeros - data lost to alignment
features_both(find(labels_both(:,1)==0),:) = [];
labels_both(find(labels_both(:,1)==0),:) = [];

save('_data_raw', 'features_both', 'labels_both');

end
