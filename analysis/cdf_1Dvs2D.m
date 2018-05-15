%% CDF compare,one dim vs two dim
clear
clc
load glo.mat
cd (work_path)
data_version='1';
load (['data/fingerprints' data_version '.mat']);

for area_i=1:length(area_table)
    fp=fps{area_i};
    c=1;
    if isfield(fp,'rqs_num')
        rqs_num=fp.rqs_num;
        distance_magnitude=zeros(1,rqs_num*rqs_num);
        distance_magnetic=zeros(1,rqs_num*rqs_num);
        rqs_magnitude=fp.magnitudes;
        rqs_magnetic=fp.magnetics;
        for i=1:rqs_num
            for j=1:rqs_num
                distance_magnitude(c)=abs(rqs_magnitude(i)-rqs_magnitude(j));
                distance_magnetic(c)=distance(rqs_magnetic(i,:),rqs_magnetic(j,:));
                c=c+1;
            end
        end
        mycdfplot(distance_magnitude(:),1,'Euclidean distance','CDF','b','-',[0 60],0:10:60);
        mycdfplot(distance_magnetic(:),0,'Euclidean distance','CDF','r','-',[0 60],0:10:60);
        legend(gca,'Magnetic magnitude','Magnetic components','WiFi');
        savegcf(['figures/' area_table{area_i} '_1vs2']);
    end
end
