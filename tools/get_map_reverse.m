function map_r=get_map_reverse(map)
map_keys=keys(map);
map_values=values(map);
map_r=containers.Map(map_values,map_keys);
