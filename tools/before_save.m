function db=before_save(db,outdoor_magnetics)
db.num=size(db.cdns,1);
db.distance_center=zeros(db.num,1);
for j=1:db.num
    db.distance_center(j)=distance(db.magnetics(j,:),outdoor_magnetics);
end
db.magnitudes=sqrt(db.magnetics(:,1).*db.magnetics(:,1)+db.magnetics(:,2).*db.magnetics(:,2));
% rssi pca process
if isfield(db,'rssis')
    rssis=cell2mat(db.rssis);
    db.rssi_rqs_set=cell(length(db.bssid_map),1);
    for j=1:length(db.bssid_map)
        db.rssi_rqs_set{j}=rssis(:,j)~=-100;
    end
    [coef, score, latent, tsquared, explained] = pca(rssis);
    ac=cumsum(latent)./sum(latent);
%         figure
%         plot(1:length(latent),ac,'b*-');
    r=getError(1:length(latent),ac,0.9);
    if r<size(score,2)
        db.rssis_pca=score(:,1:r+1);
    else
        db.rssis_pca=score(:,1:r);
    end
    db.rssis_coef=coef;
    db.rssis_mean=mean(rssis,1);
    db.rssis_r=r+1;
end