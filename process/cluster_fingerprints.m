%调用Kmeans函数
%X N*P的数据矩阵
%Idx N*1的向量,存储的是每个点的聚类标号
%Ctrs K*P的矩阵,存储的是K个聚类质心位置
%SumD 1*K的和向量,存储的是类间所有点与该类质心点距离之和
%D N*K的矩阵，存储的是每个点与所有质心的距离;
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
% 载入指纹库&测试集
load(['data/fingerprints' data_version '.mat']);
cq='rgbcmkrgbcmkrgbcmkrgbcmkrgbcmk';
mq='oooooo^^^^^^ssssssppppppvvvvvv';
opts = statset('Display','final');
areas=[1 2 4 5 10 11];

for i=areas
    fp=fps{i};
    if isfield(fp,'rssis')
        X=cell2mat(fp.rssis);
        K=floor(fp.area_size/15);
        disp(['Cluster to ' n2s(K) 'class']);
        [Idx,Ctrs,SumD,D] = kmeans(X,K,'Replicates',5,'Options',opts);
        plot_floor_mark(fp.settings);
        for j=1:fp.num
            h=plot(fp.cdns(j,1),fp.cdns(j,2));
            set(h,'Marker',mq(Idx(j)),'Color',cq(Idx(j)),'MarkerFaceColor',cq(Idx(j)));
        end
        fp.kclass=Idx;
        disp(' ');
    end
    fps{i}=fp;
end
save(['data/fingerprints' data_version '.mat'],'fps');