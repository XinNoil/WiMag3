function db = init_database( db,is_rssi )
%INIT_FINGERPRINT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if is_rssi
    db.cdns=[];
    db.magnetics=[];
    db.magnitudes=[];
    db.rssis=[];
    db.bssid_maps=[];
    db.bssid_indexs=[];
    db.types=[];
else
    db.cdns=[];
    db.magnetics=[];
    db.magnitudes=[];
    db.types=[];
    if isfield(db,'rssis')
        db=rmfield(db,'rssis');
        db=rmfield(db,'bssid_maps');
        db=rmfield(db,'bssid_indexs');
    end
end

