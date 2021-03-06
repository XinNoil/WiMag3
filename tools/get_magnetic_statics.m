function [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim)
load glo.mat
load (['data/fingerprints' data_version '.mat']);
fp=fps{area_i};

if magnetic_dim==2
    mag_max=[0 0];
    mag_min=[0 0];
    mag_max(1)=max(fp.magnetics(:,1));
    mag_max(2)=max(fp.magnetics(:,2));
    mag_min(1)=min(fp.magnetics(:,1));
    mag_min(2)=min(fp.magnetics(:,2));
else
    mag_max=max(fp.magnitudes);
    mag_min=min(fp.magnitudes);
end
if max(mag_max)>200
    disp('magnetic is too large!!!!!!')
    indexs=find(fp.magnitudes>200);
    for i=indexs
        fp.magnetics(i,:)=fp.magnetics(i-1,:);
        fp.magnitudes(i)=fp.magnitudes(i-1);
    end
    fps{area_i}=fp;
    save (['data/fingerprints' data_version '.mat'],'fps');
    if magnetic_dim==2
        mag_max=[0 0];
        mag_min=[0 0];
        mag_max(1)=max(fp.magnetics(:,1));
        mag_max(2)=max(fp.magnetics(:,2));
        mag_min(1)=min(fp.magnetics(:,1));
        mag_min(2)=min(fp.magnetics(:,2));
    else
        mag_max=max(fp.magnitudes);
        mag_min=min(fp.magnitudes);
    end
end
