load glo.mat
cd (work_path)
mkdir data
mkdir figures
mkdir result
for i=1:length(area_table)
    mkdir(['data/' area_table{i}]);
    mkdir(['figures/' area_table{i}]);
    mkdir(['result/' area_table{i}]);
end