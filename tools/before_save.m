function db=before_save(db,outdoor_magnetics)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for computing some features before saving the database
%           该函数用于在保存数据库之前计算一些特征值。
% Contact:  jiankunwang@tju.edu.cn
db.num=size(db.cdns,1);
db.distance_center=zeros(db.num,1);
for j=1:db.num
    db.distance_center(j)=distance(db.magnetics(j,:),outdoor_magnetics);
end
db.magnitudes=sqrt(db.magnetics(:,1).*db.magnetics(:,1)+db.magnetics(:,2).*db.magnetics(:,2));