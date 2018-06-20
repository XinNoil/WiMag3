%% ÷∏Œ∆ø‚≤Â÷µ
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load (['data/fingerprints' data_version '.mat']);
is_rssi=[true true false true true];
i_areas=1:5;
i_areas=i_areas(is_rssi);
outdoor_magnetics=[28.5 -43.6];
for i=i_areas
    fp=fps{i};
    plot_floor_mark(fp.settings);
    fp.cdns_i=[];
    for j=1:length(fp.settings)
        st=fp.settings{j};
        bs=st.block_size;
        row_index=myinterp(bs,st.gridmesh(2).row_index(2:end-1));
        column_index=myinterp(bs,st.gridmesh(2).column_index);
        row_index=row_index+st.origin(1);
        column_index=column_index+st.origin(2);
        [X,Y]=meshgrid(row_index,column_index);
        cdns_i=[X(:) Y(:)];
        fp.cdns_i=[fp.cdns_i;cdns_i];
    end
    plot(fp.cdns_i(:,1),fp.cdns_i(:,2),'r*');
    X=fp.cdns(:,1);
    Y=fp.cdns(:,2);
    Z1=fp.magnetics(:,1);
    Z2=fp.magnetics(:,2);
    [fitresult1, gof] = createFit(X, Y, Z1);
    [fitresult2, gof] = createFit(X, Y, Z2);
    fp.magnetics_i=[fitresult1(fp.cdns_i(:,1),fp.cdns_i(:,2)) fitresult2(fp.cdns_i(:,1),fp.cdns_i(:,2))];
    if any(isnan(fp.magnetics_i))
        disp('Error');
    end
    fp.num_i=size(fp.magnetics_i,1);
    fp.distance_center_i=zeros(fp.num_i,1);
    for j=1:fp.num_i
        fp.distance_center_i(j)=distance(fp.magnetics_i(j,:),outdoor_magnetics);
    end
    fp.magnitudes_i=sqrt(fp.magnetics_i(:,1).*fp.magnetics_i(:,1)+fp.magnetics_i(:,2).*fp.magnetics_i(:,2));
    fps{i}=fp;
end
save (['data/fingerprints' data_version '.mat'],'fps');
%     X=fp.cdns(:,1);
%     Y=fp.cdns(:,2);
%     Z1=fp.magnetics(:,1);
%     Z2=fp.magnetics(:,2);
%     [fitresult1, gof] = createFit(X, Y, Z1)
%     [fitresult2, gof] = createFit(X, Y, Z2)
%     fitresult(X,Y)