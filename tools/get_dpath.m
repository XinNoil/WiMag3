function path = get_dpath( i_area,i_subarea,folder )
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for getting the path of origin data.
%           �ú������ڻ��ԭʼ���ݵ�·����
% Contact:  jiankunwang@tju.edu.cn
load glo.mat area_table
path=['original_data/' area_table{i_area} '/' folder '/' num2str(i_subarea) '/'];