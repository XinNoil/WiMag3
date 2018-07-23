% Date:     2017/11/06
% Auther:   WJK
% Function: This Script construct area settings of 55-4-W.
%           这个脚本用于创建55-4-W区域的设置
% Contact:  jiankunwang@tju.edu.cn

function plot_floor(st,local,vars)
% 创建区域
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
% 画砖线
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
%     num=length(st.rows);
%     s=st.margin(2);
%     for i=1:num
%         rows(i).index=s+[0:block_size:block_size*st.rows(i)];
%         s=rows(i).index(end)+st.gap(i);
%     end
%     for i=1:num
%         for j=0:st.rows(i)
%             plot(offset.x+[columns(i).index(1) columns(i).index(end)],offset.y+st.margin(3)+[j*block_size j*block_size],'k-');
%         end
%         for j=0:st.columns
%             plot(offset.x+columns(i).index(1)+[j*block_size j*block_size],offset.y+st.margin(3)+[0 st.rows*block_size],'k-');
%         end
%     end
% end
% 磁性物体
if isfield(st,'magnetic_object_cdns')
    mq='so^p';
    mo_num=size(st.magnetic_object_cdns,1);
    H=zeros(1,mo_num);
    for i=1:mo_num
        H(i)=plot(offset.x+st.margin(3)+st.magnetic_object_cdns(i,1),offset.y+st.margin(2)+st.magnetic_object_cdns(i,2),'k');
        set(H(i),'Marker',mq(st.magnetic_object_type(i)+1),'MarkerSize',10,'MarkerFaceColor','k');
    end
end
if isfield(st,'magnetic_room')
    mr_num=length(st.magnetic_room);
    for i=1:mr_num
        mr=st.magnetic_room(i);
        plot(offset.x+[mr.x mr.x+mr.width],offset.y+[mr.y mr.y],'k-');
        plot(offset.x+[mr.x mr.x+mr.width],offset.y+[mr.y+mr.height mr.y+mr.height],'k-');
        plot(offset.x+[mr.x mr.x],offset.y+[mr.y mr.y+mr.height],'k-');
        plot(offset.x+[mr.x+mr.width mr.x+mr.width],offset.y+[mr.y mr.y+mr.height],'k-');
    end
end
if nargin>2
    if isfield(vars,'plot01')
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
if nargin>2
    if isfield(vars,'plot_sub')
        for i=1:length(vars.area_vertexs)
            avs=vars.area_vertexs;
            h=plot([avs(i).xv avs(i).xv(1)],[avs(i).yv avs(i).yv(1)],'r');
            set(h,'linewidth',0.5,'linestyle','--');
            center=avs(i).center;
            ht=text(center(1),center(2),n2s(i));
            set(ht,'fontsize',20,'color','r','HorizontalAlignment', 'center');
        end
    end
end
end


