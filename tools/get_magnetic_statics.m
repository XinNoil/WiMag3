function [mag_max,mag_min]=get_magnetic_statics(area_i)
load glo.mat
load (['data/fingerprints' data_version '.mat']);
fp=fps{area_i};
mag_max=[0 0];
mag_min=[0 0];
mag_max(1)=max(fp.magnetics(:,1));
mag_max(2)=max(fp.magnetics(:,2));
mag_min(1)=min(fp.magnetics(:,1));
mag_min(2)=min(fp.magnetics(:,2));
