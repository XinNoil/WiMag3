clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
areas_i=[1 2 4 5];
for i=1:length(areas_i)
    % training
    area_i=areas_i(i);
    [mag_max,mag_min]=get_magnetic_statics(area_i);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    load(['data_new/fingerprints' data_version 's_' area_table{area_i} '.mat']);
    mm=[];
    for s=1:length(sub_fps)
        fp=sub_fps{s};
        cdns=fp.cdns;
        labels=cdns-cdn_min;
        magnetics=my_norm(fp.magnetics,mag_max,mag_min);
        rssis=fp.rssi;
    %     rssis=cell2mat(fp.rssis);
        rssis=(rssis+100)/70;
        rssis(rssis<0)=0;
        rssis(rssis>1)=1;
        m=[labels magnetics rssis];
        csv_head=cell(1,size(m,2));
        bssid_map=keys(fp.bssid_map);
        for j=1:size(rssis,2)
            csv_head{j+4}=bssid_map{j};
        end
        disp(['data_new/' area_table{area_i} '_s' n2s(fp.sub_i) '_training.csv']);
        csvwrite(['data_new/' area_table{area_i} '_s' n2s(fp.sub_i) '_training.csv'],m);
        mm=[mm;m];
    end
    disp(['data_new/' area_table{area_i} '_s0_training.csv']);
    csvwrite(['data_new/' area_table{area_i} '_s0_training.csv'],mm);
end
for i=1:length(areas_i)
    % testing
    area_i=areas_i(i);
    [mag_max,mag_min]=get_magnetic_statics(area_i);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    load(['data_new/testdatas' data_version 's_' area_table{area_i} '.mat']);
    mm=[];
    for s=1:length(sub_tds)
        td=sub_tds{s};
        tdcdns=td.cdns;
        labels=tdcdns-cdn_min;
        magnetics=my_norm(td.magnetics,mag_max,mag_min);
        rssis=td.rssi;
    %     rssis=cell2mat(td.rssis);
        rssis=(rssis+100)/70;
        rssis(rssis<0)=0;
        rssis(rssis>1)=1;
        m=[labels magnetics rssis];
        csv_head=cell(1,size(m,2));
        bssid_map=keys(td.bssid_map);
        for j=1:size(rssis,2)
            csv_head{j+4}=bssid_map{j};
        end
        disp(['data_new/' area_table{area_i} '_s' n2s(td.sub_i) '_testing.csv']);
        csvwrite(['data_new/' area_table{area_i} '_s' n2s(td.sub_i) '_testing.csv'],m);
        mm=[mm;m];
    end
    disp(['data_new/' area_table{area_i} '_s0_testing.csv']);
    csvwrite(['data_new/' area_table{area_i} '_s0_testing.csv'],mm);
end
%         settings(i).name=area_table(area_i);
%         settings(i).bssid_map=bssid_map;

%     % testing
%     load (['data/' area_table{area_i} '/testdata' data_version '.mat']);
%     if is_one_hot
%         labels=zeros(td.num,length(selected_index));
%         for p=1:td.num
% %             for q=1:fp.num
% %                 labels(p,q)=exp(-distance(td.cdns(p,:),cdns(q,:)));
% %             end
%             for q=1:length(selected_index)
%                 labels(p,q)=exp(-distance(td.cdns(p,:),cdns(selected_index(q),:)));
%             end
%             labels(p,:)=labels(p,:)/sum(labels(p,:));
%         end
%     else
%         labels=td.cdns;
%     end
%     magnetics=td.magnetics;
%     if is_pca
%         fp_rssis=fp.rssis_pca;
%         td_rssis=cell2mat(td.rssis);
%         score=(td_rssis-fp.rssis_mean)*fp.rssis_coef;
%         rssis=score(:,1:fp.rssis_r);
%     else
%         rssis=cell2mat(td.rssis);
%         rssis=(rssis+100)/70;
%         rssis(rssis<0)=0;
%         rssis(rssis>1)=1;
%     end
%     m_t=[labels magnetics rssis];
%     csvwrite(['data/' area_table{area_i} '_testing.csv'],m_t);

% settingsJson=jsonencode(settings);
% fid = fopen('data/settings.json', 'w');
% fprintf(fid,'%s',settingsJson); 
% fclose(fid);