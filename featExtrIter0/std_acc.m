function opt=std_acc(Sorted, start_len, end_len,int_col)


j=1;
for   i=start_len:32:end_len
    opt(1,j)=std(Sorted(i:i+63,int_col));
    j=j+1;
end

j=1;
for   i=start_len:32:end_len
    opt(2,j)=std(Sorted(i:i+63,int_col+1));
    j=j+1;
end

j=1;
for   i=start_len:32:end_len
    opt(3,j)=std(Sorted(i:i+63,int_col+2));
    j=j+1;
end
