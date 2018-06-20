function [cdn_max,cdn_min]=get_cdns_statics(area_i)
load glo.mat
load (['data/fingerprints' data_version '.mat']);
fp=fps{area_i};
cdn_max=[0 0];
cdn_min=[0 0];
cdn_max(1)=max(fp.cdns(:,1));
cdn_max(2)=max(fp.cdns(:,2));
cdn_min(1)=min(fp.cdns(:,1));
cdn_min(2)=min(fp.cdns(:,2));