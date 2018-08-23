function row_index=create_row_2(block_size,gap,margin,columns,in_gap,flag1,flag2)
% Date:     2017/11/06
% Auther:   WJK
% Function: This function is used for creating row_index with 'in_gap' for 'area_setting.m'.
%           �����������Ϊ'area_setting.m'������'in_gap'���������ꡣ
% Notes:    ����55¥4��ĵذ�ש����һ�����ɵģ��˳�����ݵذ����й��ɹ����ذ�ש�������ꡣ
%           �ù����ǣ��ذ�ש����ÿ�����оͳ���һ��15cm�ĸ���
%           ͬʱ����һЩλ���ϴ��ڲ�������ש�����Խ���������ש��λ����Ϊ�ڲ����ϼ�in_gap
%           ʾ����'setting files/set_55_5_W.m'
%   s       ����ԭ�����꣨���������꼴Ϊ0��
%   columns ����֮��ĵذ�ש����
%   in_gap  ������ש���λ�ã��ڲ�����
%   flag1   delete the first point ɾ����ʼ��
%   flag2   delete the last point ɾ��ĩβ��
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