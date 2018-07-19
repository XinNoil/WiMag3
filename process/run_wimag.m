clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);

for area_i=1:length(area_table)
    save tmp/tmp.mat
    if is_rssi(area_i)&&~isempty(tds{area_i})
        WiMag3
        clear
    end
    load tmp/tmp.mat
end