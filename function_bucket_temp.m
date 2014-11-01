function opt=function_bucket_temp(buck_numb,len,s_mean)

for i=1:len(buck_numb)
feature_bucket_t(i,1:3)=s_mean{1,buck_numb}(:,i);
feature_bucket_t(i,4:6)=s_mean{2,buck_numb}(:,i);
feature_bucket_t(i,7:9)=s_mean{3,buck_numb}(:,i);
end

opt=feature_bucket_t;
