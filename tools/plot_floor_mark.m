function H=plot_floor_mark(settings,cdns,data,n)
    is_plot_floors=true;
    if nargin==4&&n==0
        is_plot_floors=false;
    end
    if is_plot_floors
        if nargin==4&&n==1
        else
            figure('color','white');
        end
        
        hold on;
        box on;
        set(gca,'fontsize',15);
        xlabel('X','fontsize',15,'FontWeight','bold','FontName','times new roman');
        ylabel('Y','fontsize',15,'FontWeight','bold','FontName','times new roman');
        for i=1:length(settings)
            plot_floor(settings{i},false,1);
        end
        xl=get(gca,'xlim');
        yl=get(gca,'ylim');
        set(gcf,'Units','centimeters','Position',[0 1 (xl(2)-xl(1))*1 (yl(2)-yl(1))*1]);
    end
    if nargin>1
        if islogical(data)
            plot(cdns(data,1),cdns(data,2),'r*');
            plot(cdns(~data,1),cdns(~data,2),'b*');
        else
            cm=colormap(jet);
            if max(abs(data))>1
                d1=max(data);
                d2=min(data);
                data=data-min(data);
                data=data/max(data);
                colorbar('ytick',0:0.2:1,'yticklabel',d2:(d1-d2)/5:d1);
            else
                colorbar;
            end
            H=zeros(size(cdns,1),1);
            for i=1:size(cdns,1)
                h=plot(cdns(i,1),cdns(i,2),'*');
                c=cm(round(data(i)*63)+1,:);
                hold on;
                set(h,'color',c,'markerfacecolor',c,'markersize',5);
                H(i)=h;
            end
        end
    end
end
