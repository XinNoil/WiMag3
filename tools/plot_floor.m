function plot_floor(st,local,vars)
% Date:     2017/11/06
% Auther:   WJK
% Function: This function is used to plot floorplan with a setting struct.
%           这个函数用于根据一个设置结构体画平面图。
% Contact:  jiankunwang@tju.edu.cn
%% 创建区域
if local
    figure('color','white');
    hold on;
    box on;
    xlim([0 st.M]);
    ylim([0 st.N]);
    offset.x=0;
    offset.y=0;
else
    offset.x=st.origin(1);
    offset.y=st.origin(2);
    plot(offset.x+[0 st.M],offset.y+[0 0],'k--');
    plot(offset.x+[0 st.M],offset.y+[st.N st.N],'k--');
    plot(offset.x+[0 0],offset.y+[0 st.N],'k--');
    plot(offset.x+[st.M st.M],offset.y+[0 st.N],'k--');
end
%% 画砖线
if length(st.rows)<=length(st.columns)
    block_size=st.block_size;
    num=length(st.columns);
    s=st.margin(3);
    for i=1:num
        columns(i).index=s+[0:block_size:block_size*st.columns(i)];
        s=columns(i).index(end)+st.gap(i);
    end
    for i=1:num
        for j=0:st.rows
            plot(offset.x+[columns(i).index(1) columns(i).index(end)],offset.y+st.margin(2)+[j*block_size j*block_size],'k-');
        end
        for j=0:st.columns(i)
            plot(offset.x+columns(i).index(1)+[j*block_size j*block_size],offset.y+st.margin(2)+[0 st.rows*block_size],'k-');
        end
    end
else
    block_size=st.block_size;
    num=length(st.rows);
    s=st.margin(2);
    for i=1:num
        rows(i).index=s+[0:block_size:block_size*st.rows(i)];
        s=rows(i).index(end)+st.gap(i);
    end
    for i=1:num
        for j=0:st.rows(i)
            plot(offset.x+st.margin(3)+[0 st.columns*block_size],offset.y+rows(i).index(1)+[j*block_size j*block_size],'k-');
        end
        for j=0:st.columns
            plot(offset.x+st.margin(3)+[j*block_size j*block_size],offset.y+[rows(i).index(1) rows(i).index(end)],'k-');
        end
    end
end
%% 画采样点
if nargin>2
    if isfield(vars,'plot_gridmesh')
        for i=1:length(st.gridmesh)
            [X,Y]=meshgrid(st.gridmesh(i).row_index,st.gridmesh(i).column_index);
            switch st.gridmesh(i).type
                case '0'
                    plot(offset.x+X,offset.y+Y,'r^');
                case '1'
                    plot(offset.x+X,offset.y+Y,'bo');
            end
        end
    end
end
end


