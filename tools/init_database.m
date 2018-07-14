function db = init_database( db,is_rssi )
%INIT_FINGERPRINT 此处显示有关此函数的摘要
%   此处显示详细说明
if is_rssi
    db.cdns=[];
    db.magnetics=[];
    db.magnitudes=[];
    db.rssis=[];
    db.bssid_maps=[];
    db.bssid_indexs=[];
    db.types=[];
    db.wfiles={};
    db.sfiles={};
    db.duties=[];
else
    db.cdns=[];
    db.magnetics=[];
    db.magnitudes=[];
    db.types=[];
    db.sfiles={};
    if isfield(db,'rssis')
        db=rmfield(db,'rssis');
        db=rmfield(db,'bssid_maps');
        db=rmfield(db,'bssid_indexs');
    end
end

