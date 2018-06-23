clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);
load(['data/testdatas' data_version '.mat']);
show_type='rssi';
show_which_rssi='all';
show_rssi_indexs=[];
for area_i=4 % areas
    fp=fps{area_i};
    td=tds{area_i};
    rssis=cell2mat(fp.rssis);
    bssid_map_r=get_map_reverse(fp.bssid_map);
    fpcdns=fp.cdns;
    tdcdns=td.cdns;
    save data/tmp.mat td fp fpcdns tdcdns show_type
    switch show_which_rssi
        case 'all'
            show_rssi_indexs=1:size(rssis,2);
        case 'input'
            show_rssi_indexs=input('rssi index:');
    end
    bads=false(length(show_rssi_indexs),1);
    for i=1:length(show_rssi_indexs)
        show_rssi_map(fp,td,show_rssi_indexs(i));
        bad=input([bssid_map_r(show_rssi_indexs(i)) ' have problem?: (y/n)'],'s');
        if strcmp(bad,'y')
            bads(i)=true;
        end
        close;
    end
end