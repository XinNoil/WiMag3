function H=plot_floor_mark(settings,cdns,data,n,dlim)
% Date:     2017/11/06
% Auther:   WJK
% Function: This function is used to plot floorplan with a setting struct.
%           这个函数用于根据一个设置结构体画平面图。
%   *settings:  settings of this floorplan.
%    cdns:      coordinates.
%    data:      data for each coordinate.
%    n:         new figure or not.
% Contact:  jiankunwang@tju.edu.cn
is_plot_floors=true;
if nargin>3&&n==0
    is_plot_floors=false;
end
if is_plot_floors
    if nargin>3&&n==1
    else
        figure('color','white');
    end
    hold on;
    box on;
    set(gca,'fontsize',15);
    xlabel('X','fontsize',15,'FontWeight','bold','FontName','times new roman');
    ylabel('Y','fontsize',15,'FontWeight','bold','FontName','times new roman');
    for i=1:length(settings)
        plot_floor(settings{i},false);
    end
    xl=get(gca,'xlim');
    yl=get(gca,'ylim');
    set(gcf,'Units','centimeters','Position',[0 1 (xl(2)-xl(1))*1 (yl(2)-yl(1))*1.2]);
end
if nargin>1
    if ~exist('data','var')
        plot(cdns(:,1),cdns(:,2),'ro');
        return;
    end
    if islogical(data)
        plot(cdns(data,1),cdns(data,2),'ro');
        plot(cdns(~data,1),cdns(~data,2),'bo');
    else
        cm=colormap(jet);
        if exist('dlim','var')
            d1=dlim(2);
            d2=dlim(1);
        else
            d1=max(data);
            d2=min(data);
        end
        data(data>d1)=d1;
        data(data<d2)=d2;
        data=data-d2;
        H=zeros(size(cdns,1),1);
        if(d1~=0)
            data=data/d1;
        else
            disp('error:max(data)=0!');
            return;
        end
        colorbar('ytick',0:0.2:1,'yticklabel',d2:(d1-d2)/5:d1);
        for i=1:size(cdns,1)
            h=plot(cdns(i,1),cdns(i,2),'o');
            c=cm(round(data(i)*63)+1,:);
            hold on;
            set(h,'color',c,'markerfacecolor',c,'markersize',8);
            H(i)=h;
        end
    end
end
