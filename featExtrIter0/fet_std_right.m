function [opt_train, opt_test]=fet_std_right()


load('right_classall_clean.mat');
warning('off','all')
clean_right(:,1)=right_classall_clean(:,1);
clean_right(:,2:4)=right_classall_clean(:,3:5);
clean_right(:,5:7)=right_classall_clean(:,10:12);
clean_right(:,8:10)=right_classall_clean(:,45:47);

null_right=find(clean_right(:,1)==32);
clean_right(null_right,:)=[];


Sorted_right=sortrows(clean_right);


% right sensors std
for k=1:10
s_std_right{1,k}=std_acc(Sorted_right,min(find(Sorted_right(:,1)==47+k)),((max(find(Sorted_right(:,1)==47+k))/64)*64)-96,2);
end

for k=1:10
s_std_right{2,k}=std_acc(Sorted_right,min(find(Sorted_right(:,1)==47+k)),((max(find(Sorted_right(:,1)==47+k))/64)*64)-96,5);
end

for k=1:10
s_std_right{3,k}=std_acc(Sorted_right,min(find(Sorted_right(:,1)==47+k)),((max(find(Sorted_right(:,1)==47+k))/64)*64)-96,8);
end



%feature bucket std
for i=1:10
len(i)=length(s_std_right{1,i});
end

feature_bucket_right(1:sum(len(1,1)),1)=1;
for s=2:10
feature_bucket_right(sum(len(1,1:s))-(len(1,s))+1:sum(len(1,1:s)),1)=s;
end

for k=1:10
feature_bucket_right(min(find(feature_bucket_right(:,1)==k)):max(find(feature_bucket_right(:,1)==k)),2:10)=function_bucket_temp(k,len,s_std_right);
end

feature_train_right=[];
feature_test_right=[];
for k=1:10
feature_train{k}(:,:)=feature_bucket_right(min(find(feature_bucket_right(:,1)==k)):(max(find(feature_bucket_right(:,1)==k))),:);
feature_train_right=cat(1,feature_train_right,feature_train{k}(1:length(feature_train{k})*.9,:));
feature_test_right=cat(1,feature_test_right,feature_train{k}(length(feature_train{k})*.9:length(feature_train{k}),:));
end

opt_train=feature_train_right;
opt_test=feature_test_right;
end
