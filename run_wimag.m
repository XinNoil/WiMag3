clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);
test_areas=[1 2 4 5 9 10 11 14 15];%1:length(area_table)
feature_modes=1:5;
for test_area=test_areas
    if is_rssi(test_area)&&~isempty(tds{test_area})
        for feature_mode=feature_modes
            save tmp/wimag.mat
            WiMag3
            clear
            load tmp/wimag.mat
        end
    end
end