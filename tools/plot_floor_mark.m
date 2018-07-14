function H=plot_floor_mark(settings,cdns,data,n,is_split,sub_grid_size)
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
    if nargin>4
        if(is_split)
            for s_i=1:length(settings)
                setting=settings{s_i};
                origin=setting.origin;
                M=setting.M;
                N=setting.N;
                M_n=ceil(M/sub_grid_size);
                N_n=ceil(N/sub_grid_size);
                subarea_row_index=origin(1)+[(0:M_n-1).*sub_grid_size M];
                subarea_column_index=origin(2)+[(0:N_n-1).*sub_grid_size N];
                for i=1:M_n+1
                    plot([subarea_row_index(i) subarea_row_index(i)],[subarea_column_index(1) subarea_column_index(end)],'b--');
                end
                for j=1:N_n+1
                    plot([subarea_row_index(1) subarea_row_index(end)],[subarea_column_index(j) subarea_column_index(j)],'b--');
                end
            end
        end
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
            if max(abs(data))>1
                d1=max(data);
                d2=min(data);
                data=data-min(data);
                if(max(data)~=0 )
                    data=data/max(data);
                end
                colorbar('ytick',0:0.2:1,'yticklabel',d2:(d1-d2)/5:d1);
            else
                colorbar;
            end
            H=zeros(size(cdns,1),1);
            for i=1:size(cdns,1)
                h=plot(cdns(i,1),cdns(i,2),'o');
                c=cm(round(data(i)*63)+1,:);
                hold on;
                set(h,'color',c,'markerfacecolor',c,'markersize',8);
                H(i)=h;
            end
        end
    end
end
