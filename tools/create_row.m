function row_index=create_row(block_size,gap,margin,columns,flag1,flag2)
% Date:     2017/11/06
% Auther:   WJK
% Function: This function is used for creating row_index for 'area_setting.m'.
%           这个函数用于为'area_setting.m'创建行内坐标。
% Notes:    由于55楼4层的地板砖是有一定规律的，此程序根据地板排列规律构建地板砖顶点坐标。
%           该规律是：地板砖常常每隔几列就出现一个15cm的隔断
%   s       区域原点坐标（子区域坐标即为0）
%   columns 隔断之间的地板砖列数
%   flag1   delete the first point 删除起始点
%   flag2   delete the last point 删除末尾点
% Contact:  jiankunwang@tju.edu.cn
row_index=[];
num=length(columns);
s=margin;
for i=1:num
    temp=s+[0:block_size:block_size*columns(i)];
    s=temp(end)+gap(i);
    row_index=[row_index temp];
end
if flag1
    row_index=row_index(2:end);
end
if flag2
    row_index=row_index(1:end-1);
end