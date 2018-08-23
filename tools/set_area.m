function setting=set_area(area,block_size,rows,columns,gap,margin,origin,M,N,gridmesh)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for creating a new subarea.
%           该函数用于创建一个新的子区域。
% Contact:  jiankunwang@tju.edu.cn
setting.area=area;
setting.block_size=block_size;
setting.rows=rows;
setting.columns=columns;
setting.gap=gap;
setting.margin=margin;
setting.origin=origin;
setting.M=M;
setting.N=N;
setting.gridmesh=gridmesh;
setting.area_size=M*N;