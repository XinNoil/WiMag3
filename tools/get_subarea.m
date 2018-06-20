function sub_i=get_subarea(cdns,settings,ws,sub_grid_size)
sub_i=zeros(size(cdns,1),1);
for i=1:size(cdns)
    origin=settings{ws(i)}.origin;
    cdn=cdns(i,:)-origin;
    N=settings{ws(i)}.N;
    N_n=ceil(N/sub_grid_size);
    sub_row=floor(cdn(1)./sub_grid_size);
    sub_column=floor(cdn(2)./sub_grid_size);
    sub_i(i)=sub_row.*N_n+sub_column;
    if(sub_i(i)>=100)
        disp('error: origin sub_i>=100');
    end
    sub_i(i)=sub_i(i)+ws(i)*100;
end