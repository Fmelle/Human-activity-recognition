clear all
close all
clc
tic
% [features_mean_right_train,features_mean_right_test]=fet_mean_right();
[features_mean_left_train,features_mean_left_test]=fet_mean_left();

% [features_std_right_train,features_std_right_test]=fet_std_right();
% [features_std_left_train,features_std_left_test]=fet_std_left();

% [result_mean_right] = multisvm(features_mean_right_train(:,2:10),features_mean_right_train(:,1),features_mean_right_test(:,2:10));
[result_mean_left] = multisvm(features_mean_left_train(:,2:10),features_mean_left_train(:,1),features_mean_left_test(:,2:10));

% [result_std_right] = multisvm(features_std_right_train(:,2:10),features_std_right_train(:,1),features_std_right_test(:,2:10));
% [result_std_left] = multisvm(features_std_left_train(:,2:10),features_std_left_train(:,1),features_std_left_test(:,2:10));

ctr=0;
for i=1:length(result_mean_left)
    if(result_mean_left(i,1)==features_mean_left_test(i,1))
    ctr=ctr+1;
    end
end

accuracy=(ctr/length(result_mean_left))*100
toc
