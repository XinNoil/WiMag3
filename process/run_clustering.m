clear
clc
load glo.mat
cd (work_path)
data_version='1';
% ����ָ�ƿ�&���Լ�
load(['data/fingerprints' data_version '.mat']);
cq='rgbcmkrgbcmkrgbcmkrgbcmkrgbcmk';
mq='oooooo^^^^^^ssssssppppppvvvvvv';
bTest=1;
for i=1:length(area_table)
    fp=fps{i};
    if isfield(fp,'rssis')
        opts = statset('Display','final');
        %����Kmeans����
        %X N*P�����ݾ���
        %Idx N*1������,�洢����ÿ����ľ�����
        %Ctrs K*P�ľ���,�洢����K����������λ��
        %SumD 1*K�ĺ�����,�洢����������е���������ĵ����֮��
        %D N*K�ľ��󣬴洢����ÿ�������������ĵľ���;
        X=cell2mat(fp.rssis);
        if bTest==1
            load(['data/' area_table{i} '/testdata' data_version '.mat']);
            X=[X;cell2mat(td.rssis)];
        end
        K=floor(fp.area_size/15);
        [Idx,Ctrs,SumD,D] = kmeans(X,K,'Replicates',3,'Options',opts);
        plot_floor_mark(fp.settings);
        for j=1:fp.rqs_num
            h=plot(fp.cdns(j,1),fp.cdns(j,2));
            set(h,'Marker',mq(Idx(j)),'Color',cq(Idx(j)),'MarkerFaceColor',cq(Idx(j)));
        end
        if bTest==1
            for j=1:td.test_num
                h=plot(td.cdns(j,1),td.cdns(j,2));
                set(h,'Marker',mq(Idx(j+fp.rqs_num)),'Color',cq(Idx(j+fp.rqs_num)),'MarkerFaceColor',cq(Idx(j+fp.rqs_num)));
            end
        end
        disp(' ');
    end
end
save(['data/fingerprints' data_version '.mat'],'fps');