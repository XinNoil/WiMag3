if ~exist('./tmp','dir')
    mkdir('./tmp');
end
if ~exist(['./tmp/' save_path],'dir')
    mkdir(['./tmp/' save_path]);
end
if ~exist(['./tmp/' save_path '/' area_table{area_i}],'dir')
    mkdir(['./tmp/' save_path '/' area_table{area_i}]);
end