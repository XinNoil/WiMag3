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
        rssis=rssis+100;
        rssis(rssis<0)=0;
        rssis(rssis>70)=70;
        m=[labels magnetics rssis];
        csv_head=cell(1,size(m,2));
        bssid_map=keys(fp.bssid_map);
        for j=1:size(rssis,2)
            csv_head{j+4}=bssid_map{j};
        end
        disp(['data_new2/' area_table{area_i} '_se' n2s(fp.sub_i) '_training.csv']);
        csvwrite(['data_new2/' area_table{area_i} '_se' n2s(fp.sub_i) '_training.csv'],m);
        mm=[mm;m];
    end
    disp(['data_new2/' area_table{area_i} '_se0_training.csv']);
    csvwrite(['data_new2/' area_table{area_i} '_se0_training.csv'],mm);
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
        rssis=rssis+100;
        rssis(rssis<0)=0;
        rssis(rssis>70)=70;
        m=[labels magnetics rssis];
        csv_head=cell(1,size(m,2));
        bssid_map=keys(td.bssid_map);
        for j=1:size(rssis,2)
            csv_head{j+4}=bssid_map{j};
        end
        disp(['data_new2/' area_table{area_i} '_se' n2s(td.sub_i) '_testing.csv']);
        csvwrite(['data_new2/' area_table{area_i} '_se' n2s(td.sub_i) '_testing.csv'],m);
        mm=[mm;m];
    end
    disp(['data_new2/' area_table{area_i} '_se0_testing.csv']);
    csvwrite(['data_new2/' area_table{area_i} '_se0_testing.csv'],mm);
end