if ~exist('./tmp','dir')
    mkdir('./tmp');
end
if ~exist('./tmp/rss_map6','dir')
    mkdir('./tmp/rss_map6');
end
if ~exist(['./tmp/rss_map6/' area_table{area_i}],'dir')
    mkdir(['./tmp/rss_map6/' area_table{area_i}]);
end