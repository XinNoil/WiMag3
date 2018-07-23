function db=rssi_threshold(db,threshold)
if isfield(db,'rssis')
    rssis=db.rssis;
    rssis_m=cell2mat(rssis);
    rssis_m(rssis_m<threshold)=threshold;
    rssis=mat2cell(rssis_m,ones(1,size(rssis_m,1)),size(rssis_m,2));
    db.rssis=rssis;
    db.threshold=threshold;
end