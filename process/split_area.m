% Date:     2018/5/22
% Auther:   WJK
% Function: This Script split area to several subarea
%           �ýű���ԭʼ����ָ�Ϊ����������
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% ��������
areas=1:5;
sub_grid_size=5.001; % �������С
is_overlapped=false;

% ��������
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);

% ѭ���ָ�
for area_i=areas
    fp=fps{area_i};
    td=tds{area_i};
    cdns=fp.cdns;
    tdcdns=td.cdns;
    plot_floor_mark(fp.settings);
    plot(cdns(:,1),cdns(:,2),'r*');
    plot(tdcdns(:,1),tdcdns(:,2),'b*');
    settings=fp.settings;
    fp.ws=get_which_setting(cdns,settings,sub_grid_size);
    fp.sub_i=get_subarea(cdns,settings,fp.ws,sub_grid_size);
    td.ws=get_which_setting(tdcdns,settings,sub_grid_size);
    td.sub_i=get_subarea(tdcdns,settings,td.ws,sub_grid_size);
    if (~all(unique(fp.sub_i)==unique(td.sub_i)))
        disp('error: sub_i not same.');
    end
    for s_i=1:length(fp.settings)
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
    fps{area_i}=fp;
    tds{area_i}=td;
end
save(['data/fingerprints' data_version '.mat'],'fps');
save(['data/testdatas' data_version '.mat'],'tds');
