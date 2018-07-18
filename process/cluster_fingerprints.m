%����Kmeans����
%X N*P�����ݾ���
%Idx N*1������,�洢����ÿ����ľ�����
%Ctrs K*P�ľ���,�洢����K����������λ��
%SumD 1*K�ĺ�����,�洢����������е���������ĵ����֮��
%D N*K�ľ��󣬴洢����ÿ�������������ĵľ���;
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
% ����ָ�ƿ�&���Լ�
load(['data/fingerprints' data_version '.mat']);
cq='rgbcmkrgbcmkrgbcmkrgbcmkrgbcmk';
mq='oooooo^^^^^^ssssssppppppvvvvvv';
opts = statset('Display','final');
areas=[1 2 4 5 10 11];
cluster_area=15;

for i=areas
    fp=fps{i};
    if isfield(fp,'rssis')
        rssis=cell2mat(fp.rssis);
        K=floor(fp.area_size/cluster_area);
        disp(['Cluster to ' n2s(K) ' classes']);
        [Idx,Ctrs,SumD,D] = kmeans(rssis,K,'Replicates',5,'Options',opts);
        plot_floor_mark(fp.settings);
        for j=1:fp.num
            h=plot(fp.cdns(j,1),fp.cdns(j,2));
            set(h,'Marker',mq(Idx(j)),'Color',cq(Idx(j)),'MarkerFaceColor',cq(Idx(j)));
        end
        fp.kclass=Idx;
        fp.knum=K;
        fp.k_rssi_mask=zeros(K,length(fp.bssid_map));
        for j=1:K
            sub_rssis=rssis(Idx==j,:);
            t=abs(sub_rssis+100)>1e-3;
            fp.k_rssi_mask(j,:)=any(t);
        end
        disp(' ');
    end
    fps{i}=fp;
end
save(['data/fingerprints' data_version '.mat'],'fps');