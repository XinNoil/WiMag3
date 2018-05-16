function Station = createStation(LDB_i,fps,area_i)
% Station.d_id=LDB_i;
% Station.type='wifi';
% Station.addresses=keys(fps{area_i}.bssid_map);
% Station.parameters=1:length(Station.addresses);

Station=keys(fps{area_i}.bssid_map);