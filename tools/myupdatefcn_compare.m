function output_txt = myupdatefcn_compare(obj,event_obj)
% ��ʾ�ο�����ߴ����Ĵų�ָ�Ƽ�ԭʼ����
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).
pos = get(event_obj,'Position');
load data/tmp.mat
no=get_No(pos,fpcdns);
output_txt = {['Rqs No: ' num2str(no)],...
['X: ',num2str(pos(1),4)],...
['Y: ',num2str(pos(2),4)],...
['H:' n2s(fp.magnetics(no,1)) '  V:' n2s(fp.magnetics(no,2))]};
db=fp;

switch (show_type)
    case 'all'
        if (isfield(db,'rssis'))
            show_origin_data(db.wfiles{no},'rssi',db.bssid_map);
        end
    show_origin_data(db.sfiles{no},'mag');
    case 'mag'
        show_origin_data(db.sfiles{no},show_type);
    case 'rssi'
        show_origin_data(db.wfiles{no},show_type,db.bssid_map);
end
