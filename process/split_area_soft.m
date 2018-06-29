% Date:     2018/5/22
% Auther:   WJK
% Function: This Script split area to several subarea
%           该脚本将原始区域分割为若干子区域
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
areas=[1 2 4 5];
sub_grid_size=5.001; % 子区域大小
is_overlapped=false;

% 载入数据
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);

% 循环分割
for area_i=areas
    fp=fps{area_i};
    td=tds{area_i};
    cdns=fp.cdns;
    tdcdns=td.cdns;
    plot_floor_mark(fp.settings);
    plot(cdns(:,1),cdns(:,2),'r*');
    plot(tdcdns(:,1),tdcdns(:,2),'b*');
    settings=fp.settings;
    area_code=1;
    clear area_vertexs
    for s_i=1:length(fp.settings)
        setting=settings{s_i};
        origin=setting.origin;
        M=setting.M;
        N=setting.N;
        M_n=ceil(M/sub_grid_size*2);
        N_n=ceil(N/sub_grid_size*2);
        rows=origin(1)+[(0:M_n-1).*sub_grid_size/2 M];
        cols=origin(2)+[(0:N_n-1).*sub_grid_size/2 N];
        if length(rows)<3
            rows=[rows M+origin(1)];
        end
        if length(cols)<3
            cols=[cols N+origin(2)];
        end
        for j=1:length(cols)-2
            for i=1:length(rows)-2
                h=plot([rows(i) rows(i+2) rows(i+2) rows(i) rows(i)],[cols(j) cols(j) cols(j+2) cols(j+2) cols(j)],'r');
                set(h,'linewidth',3);
                area_vertexs(area_code).xv=[rows(i) rows(i+2) rows(i+2) rows(i)];
                area_vertexs(area_code).yv=[cols(j) cols(j) cols(j+2) cols(j+2)];
                area_vertexs(area_code).center=[(rows(i)+rows(i+2))/2 (cols(j)+cols(j+2))/2];
                center=area_vertexs(area_code).center;
                ht=text(center(1),center(2),n2s(area_code));
                set(ht,'fontsize',20,'color','r','HorizontalAlignment', 'center');
                area_code=area_code+1;
%                 pause
                set(h,'linewidth',0.5,'linestyle','--'); 
            end
        end
    end
    fp.area_vertexs=area_vertexs;
    fp.categorical_vector=get_subarea_soft(area_vertexs,cdns);
    savegcf(['setting files/' area_table{area_i} '_soft_split'],{'png','fig'})
    fps{area_i}=fp;
    tds{area_i}=td;
end
save(['data/fingerprints' data_version '.mat'],'fps');
save(['data/testdatas' data_version '.mat'],'tds');
