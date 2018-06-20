function [in,on]=get_in_setting(cdns,setting)
origin=setting.origin;
M=setting.M;
N=setting.N;
xv=[origin(1) origin(1) origin(1)+M origin(1)+M];
yv=[origin(2) origin(2)+N origin(1)+N origin(2)];
[in,on] = inpolygon(cdns(:,1),cdns(:,2),xv,yv);