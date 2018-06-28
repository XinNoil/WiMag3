clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
areas_i=[1 2 4 5];
for i=1:length(areas_i)
    % training
    area_i=areas_i(i);
    load(['data/fingerprints' data_version 's_' area_table{area_i} '.mat']);
    m=ones(length(sub_fps)+1,length(sub_fps{1}.bssid_map)+3); % 1: area code, 2-3: mag, 4:end: rssi 
    for s=1:length(sub_fps)
        fp=sub_fps{s};
        rssis=fp.rssi;
        t=abs(rssis+100)>1e-3;
        m(s,1)=fp.sub_i;
        m(s,4:end)=sum(t)==0;
    end
    m(end,1)=0;
    m(end,4:end)=any(m(1:end-1,4:end));
    disp(m(:,1)');
    disp(sum(m(:,4:end),2)');
    disp(['data_new/' area_table{area_i} '_s_rssi_indexs.csv']);
    csvwrite(['data_new/' area_table{area_i} '_s_rssi_indexs.csv'],m);
end