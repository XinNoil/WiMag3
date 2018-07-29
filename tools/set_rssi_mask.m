function fp=set_rssi_mask(fp,td,is_rssi)
num_thredhold=5;
RSSI_min=-100;
if ~isempty(td)&&is_rssi
    fprssis=cell2mat(fp.rssis);
    tdrssis=cell2mat(td.rssis);
    fpnums=sum(fprssis>RSSI_min);
    tdnums=sum(tdrssis>RSSI_min);
    fp_rssi_mask=fpnums>num_thredhold;
    td_rssi_mask=tdnums>num_thredhold;
    rssi_mask=fp_rssi_mask&td_rssi_mask;
    if isfield(fp,'rssi_mask')
        fp.rssi_mask=rssi_mask&fp.rssi_mask;
    else
        fp.rssi_mask=rssi_mask;
    end
    fp.rssi_mask_num=sum(fp.rssi_mask);
elseif is_rssi
    fp.rssi_mask=true(1,length(fp.bssid_map));
    fp.rssi_mask_num=sum(fp.rssi_mask);
end