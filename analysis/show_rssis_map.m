% Date:     2018/08/24
% Auther:   WJK
% Function: This Script .
%           ¸Ã½Å±¾¡£
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);
load(['data/testdatas' data_version '.mat']);
show_fptd = containers.Map({'fp','td'}, {true,false});
show_type='loss'; % rssi/loss
save_path=[show_type data_version];
show_which_rssi='all';
show_rssi_indexs=[];
is_run_auto=true;
areas=1:length(area_table);
areas=areas(is_rssi);
for area_i=[4] %areas
    fp=fps{area_i};
    td=tds{area_i};
    rssis=cell2mat(fp.rssis);
    bssid_map_r=get_map_reverse(fp.bssid_map);
    fpcdns=fp.cdns;
    if isempty(td)
        show_fptd('td')=false;
        save tmp/tmp.mat fp fpcdns show_type show_fptd
    else
        tdcdns=td.cdns;
        save tmp/tmp.mat td fp fpcdns tdcdns show_type show_fptd
    end
    switch show_which_rssi
        case 'all'
            show_rssi_indexs=1:size(rssis,2);
        case 'input'
            show_rssi_indexs=input('rssi index:');
    end
    bads=false(length(show_rssi_indexs),1);
    show_rssis_map_checkdir;
    for i=1:length(show_rssi_indexs)
        switch show_type
            case 'rssi'
                show_rssi_map(fp,td,show_rssi_indexs(i),show_fptd);
            case 'loss'
                show_loss_map(fp,td,show_rssi_indexs(i),show_fptd);
        end
        title([bssid_map_r(show_rssi_indexs(i)) ' ' n2s(fp.bssids_freq(show_rssi_indexs(i))) ' ' n2s(show_rssi_indexs(i))]);
        if is_run_auto
            bssid=bssid_map_r(show_rssi_indexs(i));
            savegcf(['./tmp/' save_path '/' area_table{area_i} '/' replace(bssid,':','_') '_' n2s(fp.bssids_freq(show_rssi_indexs(i))) '_' n2s(show_rssi_indexs(i))],{'png'});
        else
            bad=input([n2s(show_rssi_indexs(i)) ': ' bssid_map_r(show_rssi_indexs(i)) ' have problem?: (y/n)'],'s');
            if strcmp(bad,'y')
                bads(i)=true;
            end
        end
        close;
    end
end
% mh
% ld
% td=tds{4};
% rssis=cell2mat(td.rssis);
% rssi=rssis(:,11);
% sum(rssi>-100)