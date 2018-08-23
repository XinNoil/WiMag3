function db = init_database(db,is_rssi)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for initialing a database.
%           该函数用于初始化一个数据库。
% Contact:  jiankunwang@tju.edu.cn
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
    db.rssi_statics=[];
else
    db.cdns=[];
    db.magnetics=[];
    db.magnitudes=[];
    db.types=[];
    db.sfiles={};
end

