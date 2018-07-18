clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
% 载入指纹库&测试集
load(['data/fingerprints' data_version '.mat']);
cq='rgbcmkrgbcmkrgbcmkrgbcmkrgbcmk';
mq='oooooo^^^^^^ssssssppppppvvvvvv';
bTest=1;
areas=[1 2 4 5 10 11];

for i=areas
    fp=fps{i};
    if isfield(fp,'rssis')
        %调用Kmeans函数
        %X N*P的数据矩阵
        %Idx N*1的向量,存储的是每个点的聚类标号
        %Ctrs K*P的矩阵,存储的是K个聚类质心位置
        %SumD 1*K的和向量,存储的是类间所有点与该类质心点距离之和
        %D N*K的矩阵，存储的是每个点与所有质心的距离;
        opts = statset('Display','final');
        X=cell2mat(fp.rssis);
        if bTest==1
            load(['data/' area_table{i} '/testdata' data_version '.mat']);
            X=[X;cell2mat(td.rssis)];
        end
        K=floor(fp.area_size/15);
        [Idx,Ctrs,SumD,D] = kmeans(X,K,'Replicates',5,'Options',opts);
        plot_floor_mark(fp.settings);
        for j=1:fp.num
            h=plot(fp.cdns(j,1),fp.cdns(j,2));
            set(h,'Marker',mq(Idx(j)),'Color',cq(Idx(j)),'MarkerFaceColor',cq(Idx(j)));
        end
        if bTest==1
            for j=1:td.num
                h=plot(td.cdns(j,1),td.cdns(j,2));
                set(h,'Marker',mq(Idx(j+fp.num)),'Color',cq(Idx(j+fp.num)),'MarkerFaceColor',cq(Idx(j+fp.num)));
            end
        end
        disp(' ');
    end
end
% save(['data/fingerprints' data_version '.mat'],'fps');