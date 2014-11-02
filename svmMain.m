clear all
close all
clc
tic
[features_mean_right_train,features_mean_right_test]=fet_mean_right();
[features_mean_left_train,features_mean_left_test]=fet_mean_left();

[features_std_right_train,features_std_right_test]=fet_std_right();
[features_std_left_train,features_std_left_test]=fet_std_left();

t_train(:,1)=features_std_left_train(:,1);
t_train(:,2)=features_std_left_train(:,2);
t_train(:,3)=features_mean_left_train(:,2);
t_train(:,4)=features_std_left_train(:,3);
t_train(:,5)=features_mean_left_train(:,3);
t_train(:,6)=features_std_left_train(:,4);
t_train(:,7)=features_mean_left_train(:,4);
t_train(:,8)=features_std_left_train(:,5);
t_train(:,9)=features_mean_left_train(:,5);
t_train(:,10)=features_std_left_train(:,6);
t_train(:,11)=features_mean_left_train(:,6);
t_train(:,12)=features_std_left_train(:,7);
t_train(:,13)=features_mean_left_train(:,7);
t_train(:,14)=features_std_left_train(:,8);
t_train(:,15)=features_mean_left_train(:,8);
t_train(:,16)=features_std_left_train(:,9);
t_train(:,17)=features_mean_left_train(:,9);
t_train(:,18)=features_std_left_train(:,10);
t_train(:,19)=features_mean_left_train(:,10);



t_test(:,1)=features_std_left_test(:,1);
t_test(:,2)=features_std_left_test(:,2);
t_test(:,3)=features_mean_left_test(:,2);
t_test(:,4)=features_std_left_test(:,3);
t_test(:,5)=features_mean_left_test(:,3);
t_test(:,6)=features_std_left_test(:,4);
t_test(:,7)=features_mean_left_test(:,4);
t_test(:,8)=features_std_left_test(:,5);
t_test(:,9)=features_mean_left_test(:,5);
t_test(:,10)=features_std_left_test(:,6);
t_test(:,11)=features_mean_left_test(:,6);
t_test(:,12)=features_std_left_test(:,7);
t_test(:,13)=features_mean_left_test(:,7);
t_test(:,14)=features_std_left_test(:,8);
t_test(:,15)=features_mean_left_test(:,8);
t_test(:,16)=features_std_left_test(:,9);
t_test(:,17)=features_mean_left_test(:,9);
t_test(:,18)=features_std_left_test(:,10);
t_test(:,19)=features_mean_left_test(:,10);


% [result_mean_right] = multisvm(features_mean_right_train(:,2:10),features_mean_right_train(:,1),features_mean_right_test(:,2:10));
[result_mix_left] = multisvm(t_train(:,2:10),t_train(:,1),t_test(:,2:10));

% [result_std_right] = multisvm(features_std_right_train(:,2:10),features_std_right_train(:,1),features_std_right_test(:,2:10));
% [result_std_left] = multisvm(features_std_left_train(:,2:10),features_std_left_train(:,1),features_std_left_test(:,2:10));


ctr=0;
for i=1:length(result_mix_left)
    if(result_mix_left(i,1)==t_test(i,1))
    ctr=ctr+1;
    end
end

accuracy=(ctr/length(result_mix_left))*100
toc
