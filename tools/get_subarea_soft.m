function categorical_vector=get_subarea_soft(area_vertexs,cdns)
categorical_vector=zeros(size(cdns,1),length(area_vertexs));
for i=1:length(area_vertexs)
    xv=area_vertexs(i).xv;
    yv=area_vertexs(i).yv;
    [in,on] = inpolygon(cdns(:,1),cdns(:,2),xv,yv);
    categorical_vector(in|on,i)=1;
end
