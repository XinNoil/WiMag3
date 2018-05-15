clear
clc
load glo.mat
cd (work_path)
% 参数设置
data_version='1';
% 载入指纹库&测试集
load(['data/fingerprints' data_version '.mat']);
areas_i=[1 2 4 5];
is_pca=false;
is_one_hot=false;

for i=1:length(areas_i)
    % training
    area_i=areas_i(i);
    fp=fps{area_i};
    cdns=fp.cdns;
    selected_index=1:floor(fp.rqs_num/13):fp.rqs_num;
    if is_one_hot
        labels=zeros(fp.rqs_num,length(selected_index));
        for p=1:fp.rqs_num
%             for q=1:fp.rqs_num
%                 labels(p,q)=exp(-distance(cdns(p,:),cdns(q,:)));
%             end
            for q=1:length(selected_index)
                labels(p,q)=exp(-distance(cdns(p,:),cdns(selected_index(q),:)));
            end
            labels(p,:)=labels(p,:)/sum(labels(p,:));
        end
    else
        labels=cdns;
    end
    magnetics=fp.magnetics;
    if is_pca
        rssis=fp.rssis_pca(:,1:fp.rssis_r);
    else
        rssis=cell2mat(fp.rssis);
        rssis=(rssis+100)/70;
        rssis(rssis<0)=0;
        rssis(rssis>1)=1;
    end
    m=[labels magnetics rssis];
    csv_head=cell(1,size(m,2));
    bssid_map=keys(fp.bssid_map);
    for j=1:size(rssis,2)
        csv_head{j+4}=bssid_map{j};
    end
    settings(i).name=area_table(area_i);
    settings(i).bssid_map=bssid_map;
    csvwrite(['data/' area_table{area_i} '_training.csv'],m);
    % testing
    load (['data/' area_table{area_i} '/testdata' data_version '.mat']);
    if is_one_hot
        labels=zeros(td.test_num,length(selected_index));
        for p=1:td.test_num
%             for q=1:fp.rqs_num
%                 labels(p,q)=exp(-distance(td.cdns(p,:),cdns(q,:)));
%             end
            for q=1:length(selected_index)
                labels(p,q)=exp(-distance(td.cdns(p,:),cdns(selected_index(q),:)));
            end
            labels(p,:)=labels(p,:)/sum(labels(p,:));
        end
    else
        labels=td.cdns;
    end
    magnetics=td.magnetics;
    if is_pca
        fp_rssis=fp.rssis_pca;
        td_rssis=cell2mat(td.rssis);
        score=(td_rssis-fp.rssis_mean)*fp.rssis_coef;
        rssis=score(:,1:fp.rssis_r);
    else
        rssis=cell2mat(td.rssis);
        rssis=(rssis+100)/70;
        rssis(rssis<0)=0;
        rssis(rssis>1)=1;
    end
    m_t=[labels magnetics rssis];
    csvwrite(['data/' area_table{area_i} '_testing.csv'],m_t);
end
settingsJson=jsonencode(settings);
fid = fopen('data/settings.json', 'w');
fprintf(fid,'%s',settingsJson); 
fclose(fid);