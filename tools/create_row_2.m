function row_index=create_row_2(block_size,gap,margin,columns,in_gap,flag1,flag2)
% Date:     2017/11/06
% Auther:   WJK
% Function: This function is used for creating row_index with 'in_gap' for 'area_setting.m'.
%           这个函数用于为'area_setting.m'创建带'in_gap'的行内坐标。
% Notes:    由于55楼4层的地板砖是有一定规律的，此程序根据地板排列规律构建地板砖顶点坐标。
%           该规律是：地板砖常常每隔几列就出现一个15cm的隔断
%           同时由于一些位置上存在不完整的砖，所以将不完整的砖的位置视为内部隔断即in_gap
%           示例见'setting files/set_55_5_W.m'
%   s       区域原点坐标（子区域坐标即为0）
%   columns 隔断之间的地板砖列数
%   in_gap  不完整砖块的位置，内部隔断
%   flag1   delete the first point 删除起始点
%   flag2   delete the last point 删除末尾点
% Contact:  jiankunwang@tju.edu.cn
row_index=[];
num=length(columns);
s=margin;
for i=1:num
    temp=s+[0:block_size:block_size*columns(i)];
    s=temp(end)+gap(i);
    temp=[temp temp(end)+in_gap{i}];
    row_index=[row_index temp];
end
if flag1
    row_index=row_index(2:end);
end
if flag2
    row_index=row_index(1:end-1);
end