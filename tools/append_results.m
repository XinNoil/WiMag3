function db=append_results(db,is_rssi,results)
db.cdns=[db.cdns;results.cdns];
db.magnetics=[db.magnetics;results.magnetics];
db.types=[db.types;results.types];
db.sfiles=[db.sfiles;results.sfiles];
if is_rssi
    db.rssis=[db.rssis;results.rssis];
    db.bssid_maps=[db.bssid_maps;results.bssid_maps];
    db.bssid_indexs=[db.bssid_indexs;results.bssid_indexs];
    db.wfiles=[db.wfiles;results.wfiles];
    db.rssis_statics=[db.rssis_statics results.rssis_statics];
end