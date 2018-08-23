function row_index=create_mid_row(block_size,gap,margin,columns,flag1,flag2)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for getting middle rows(columns) indexs.
%           该函数用于获取中间点的横或纵坐标。
% Contact:  jiankunwang@tju.edu.cn
row_index=[];
num=length(columns);
s=margin;
for i=1:num
    temp=s+[0:block_size:block_size*(columns(i)-1)];
    s=temp(end)+block_size+gap(i);
    row_index=[row_index temp];
end
if flag1 
    row_index=row_index(2:end);
end
if flag2 
    row_index=row_index(1:end-1);
end