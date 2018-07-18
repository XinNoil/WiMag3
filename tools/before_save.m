function db=before_save(db,outdoor_magnetics)
db.num=size(db.cdns,1);
db.distance_center=zeros(db.num,1);
for j=1:db.num
    db.distance_center(j)=distance(db.magnetics(j,:),outdoor_magnetics);
end
db.magnitudes=sqrt(db.magnetics(:,1).*db.magnetics(:,1)+db.magnetics(:,2).*db.magnetics(:,2));