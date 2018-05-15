% Date:     2017/11/06
% Auther:   WJK
% Function: This Script construct create row_index for 'area_setting.m'.
%           ����ű�����Ϊ'area_setting.m'�����������ꡣ
% Contact:  jiankunwang@tju.edu.cn
% Notes:    ����55¥4��ĵذ�ש����һ�����ɵģ��˳�����ݵذ����й��ɹ����ذ�ש�������ꡣ
%           �ù����ǣ��ذ�ש����ÿ�����оͳ���һ��15cm�ĸ���
%   s       ����ԭ�����꣨���������꼴Ϊ0��
%   columns ����֮��ĵذ�ש����
%   flag    �Ƿ�ȥ����һ������


function row_index=create_row(block_size,gap,margin,columns,flag1,flag2)
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