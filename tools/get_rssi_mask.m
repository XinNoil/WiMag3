function rssi_mask=get_rssi_mask(fp)
if isfield(fp,'rssi_mask')
    rssi_mask=fp.rssi_mask;
else
    rssi_mask=true(1,length(fp.bssid_map));
end