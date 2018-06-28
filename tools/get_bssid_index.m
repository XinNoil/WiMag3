function indexs=get_bssid_index(bssid_map,bssids)
indexs=zeros(1,length(bssids));
for i=1:length(bssids)
    if(isKey(bssid_map,bssids{i}))
        indexs(i)=bssid_map(bssids{i});
    end
end