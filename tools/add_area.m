function add_area(name,rssi)
load glo.mat;
cd (work_path)
area_table{end+1}=name;
mkdir(['data/' area_table{end}]);
mkdir(['figures/' area_table{end}]);
mkdir(['result/' area_table{end}]);
is_rssi(end+1)=rssi;
disp(['area' n2s(length(area_table)) ':' name]);
disp(['rssi:' n2s(is_rssi)]);
save('glo.mat','-append','area_table','is_rssi');
load('glo.mat');
