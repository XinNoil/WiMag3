function plot_floor_sub(area_vertexs,area_codes,color,linestyle)
if nargin<3
    color='r';
end
for i=1:length(area_codes)
    ac=area_codes(i);
    avs=area_vertexs;
    h=plot([avs(ac).xv avs(ac).xv(1)],[avs(ac).yv avs(ac).yv(1)],color);
    if nargin >3
        set(h,'linewidth',3,'linestyle',linestyle);
    else
        set(h,'linewidth',3,'linestyle','-');
    end
    center=avs(ac).center;
    ht=text(center(1),center(2),n2s(ac));
    set(ht,'fontsize',20,'color',color,'HorizontalAlignment', 'center');
end