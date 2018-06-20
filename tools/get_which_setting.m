function ws=get_which_setting(cdns,settings,sub_grid_size)
ws=zeros(size(cdns,1),1);
for i=1:length(settings)
    setting=settings{i};
    [in,on]=get_in_setting(cdns,setting);
    ws(in)=i;
    ws(on)=i;
end
if sum(ws==0)>0
    disp('error: area not found');
end