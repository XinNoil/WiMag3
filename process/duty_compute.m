% Date:     2018/07/11
% Auther:   WJK,SYY
% Function: This Script compute duties for fingerprints
%           ����һ������WiFi�͵شŵĶ�λ�㷨
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

load(['data/fingerprints' data_version '.mat']);
for area_i=1
    fp=fps{area_i};
    duties=zeros(length(fp.wfiles),length(fp.bssid_map));
    for i=1:length(fp.wfiles)
        filename=fp.wfiles{i};
        duties(i,:)=get_duties(filename,fp.bssid_map);
    end
    fp.duties=duties;
    fps{area_i}=fp;
end

save(['data/fingerprints' data_version '.mat'],'fps');