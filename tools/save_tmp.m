function save_tmp(area_i)
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);
load(['data/testdatas' data_version '.mat']);
show_fptd = containers.Map({'fp','td'}, {true,true});
show_type='rssi';
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