function add_area(name,rssi,together)
load glo.mat;
cd (work_path)
area_table{end+1}=name;
mkdir(['data/' area_table{end}]);
mkdir(['figures/' area_table{end}]);
mkdir(['result/' area_table{end}]);
is_rssi(end+1)=rssi;
is_together{end+1}=together;
disp(['area' n2s(length(area_table)) ':' name]);
save('glo.mat','-append','area_table','is_rssi','is_together');
load('glo.mat');
