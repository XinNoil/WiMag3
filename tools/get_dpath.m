function path = get_dpath( i_area,i_subarea,folder )
%GET_DPATH 此处显示有关此函数的摘要
%   此处显示详细说明
load glo.mat area_table
path=['original_data/' area_table{i_area} '/' folder '/' num2str(i_subarea) '/'];
end

