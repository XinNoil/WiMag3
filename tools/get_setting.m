% Date:     2017/11/06
% Auther:   WJK
% Function: This Script extract area setting.
%           ����ű�������ȡ�������á�
% Contact:  jiankunwang@tju.edu.cn

function [block_size,origin,M,N,gridmesh]=get_setting(setting)
block_size=setting.block_size;
origin=setting.origin;
M=setting.M;
N=setting.N;
gridmesh=setting.gridmesh;