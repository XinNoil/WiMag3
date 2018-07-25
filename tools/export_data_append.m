if is_average
    cdns_m=[cdns_m;tmp_cdn];
    rssis_m=[rssis_m;mean(tmp_rssi,1)];
    magnetics_m=[magnetics_m;mean(tmp_magnetics,1)];
else
    cdns_m=[cdns_m ; repmat( tmp_cdn , RecordsNum , 1 )];
    magnetics_m=[magnetics_m ; tmp_magnetics];
    rssis_m=[rssis_m ; tmp_rssi];
end