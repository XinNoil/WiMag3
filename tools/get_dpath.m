function path = get_dpath( i_area,i_subarea,folder )
%GET_DPATH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
load glo.mat area_table
path=['original_data/' area_table{i_area} '/' folder '/' num2str(i_subarea) '/'];
end

