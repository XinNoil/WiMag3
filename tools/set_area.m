function setting=set_area(area,block_size,rows,columns,gap,margin,origin,M,N,gridmesh)
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
% setting.num=count_point(gridmesh);