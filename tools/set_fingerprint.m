function fp=set_fingerprint(i_area,settings)
% FINGERPRINT ¹¹Ôìº¯Êý
%   i_area,settings,rqs_num,area_size,bssid_map
fp.i_area=i_area;
fp.settings=settings;
fp.area_size=0;
for i=1:length(settings)
    fp.area_size=fp.area_size+settings{i}.area_size;
end
end

