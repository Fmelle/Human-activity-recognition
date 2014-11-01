function [opt_train,opt_test]=fet_mean_left()

load('left_classall_clean.mat');
warning('off','all')
clean_left(:,1)=left_classall_clean(:,1);
clean_left(:,2:4)=left_classall_clean(:,3:5);
clean_left(:,5:7)=left_classall_clean(:,10:12);
clean_left(:,8:10)=left_classall_clean(:,66:68);

null_left=find(clean_left(:,1)==32);
clean_left(null_left,:)=[];


Sorted_left=sortrows(clean_left);


% left sensors mean
for k=1:10
s_mean_left{1,k}=mean_acc(Sorted_left,min(find(Sorted_left(:,1)==47+k)),((max(find(Sorted_left(:,1)==47+k))/64)*64)-96,2);
end

for k=1:10
s_mean_left{2,k}=mean_acc(Sorted_left,min(find(Sorted_left(:,1)==47+k)),((max(find(Sorted_left(:,1)==47+k))/64)*64)-96,5);
end

for k=1:10
s_mean_left{3,k}=mean_acc(Sorted_left,min(find(Sorted_left(:,1)==47+k)),((max(find(Sorted_left(:,1)==47+k))/64)*64)-96,8);
end


%feature bucket
for i=1:10
len(i)=length(s_mean_left{1,i});
end

feature_bucket_left(1:sum(len(1,1)),1)=1;
for s=2:10
feature_bucket_left(sum(len(1,1:s))-(len(1,s))+1:sum(len(1,1:s)),1)=s;
end

for k=1:10
feature_bucket_left(min(find(feature_bucket_left(:,1)==k)):max(find(feature_bucket_left(:,1)==k)),2:10)=function_bucket_temp(k,len,s_mean_left);
end


feature_train_left=[];
feature_test_left=[];
for k=1:10
feature_train{k}(:,:)=feature_bucket_left(min(find(feature_bucket_left(:,1)==k)):(max(find(feature_bucket_left(:,1)==k))),:);
feature_train_left=cat(1,feature_train_left,feature_train{k}(1:length(feature_train{k})*.9,:));
feature_test_left=cat(1,feature_test_left,feature_train{k}(length(feature_train{k})*.9:length(feature_train{k}),:));
end


opt_train=feature_train_left;
opt_test=feature_test_left;

end
