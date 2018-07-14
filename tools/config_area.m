function settings=config_area( i_area )
%config_area 此处显示有关此函数的摘要
%   此处显示详细说明
load glo.mat;
vars.plot01='1';
switch area_table{i_area}
    case '55-4-W'
        set_55_4_W;
    case '55-5-W'
        set_55_5_W
    case 'PARK'
        set_PARK
    case 'LIB-1-E'
        set_LIB_1_E
    case '55-204'
        set_55_204
    case '55-2xx'
        set_55_2xx
    case '55-2-210'
        set_55_210
    case '55-5-W-2'
        set_55_5_W_2
    case '55-5-W-2h'
        set_55_5_W_2h
    case '55-4-E'
        set_55_4_E
    case '55-4'
        set_55_4
end
% 绘制整体区域示意图
end

