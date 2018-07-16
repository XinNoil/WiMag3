% Date:     2018/07/11
% Auther:   WJK,SYY
% Function: This Script compute duties for fingerprints
%           这是一个基于WiFi和地磁的定位算法
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

load(['data/fingerprints' data_version '.mat']);
for area_i=1
    fp=fps{area_i};
    duties=fp.duties;
    categorical_vector=fp.categorical_vector;
    sub_area_num=size(categorical_vector,2);
    for i=1:sub_area_num
        mask=logical(categorical_vector(:,i));
        sub_duties=duties(mask,:);
        sub_duties=sub_duties(sub_duties>0);
        [XData,YData]=mycdfplot(sub_duties,1,['Duty of soft area ' n2s(i)],'CDF','r','-',[0 1],0:0.2:1);
        savegcf(['data_new/duty/' n2s(i)]);
    end
end

save(['data/fingerprints' data_version '.mat'],'fps');