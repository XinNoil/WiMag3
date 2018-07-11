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
        [timestamp,BSSID,RSSI,~]=loadWiFiData(filename);
        BSSIDs=unique(BSSID);
        max_num=max(timestamp)+1;
        index_s=get_bssid_index(fp.bssid_map,BSSIDs);
        index=get_bssid_index(fp.bssid_map,BSSID);%����BSSID��Ӧ�ı��
        index_s(index_s==0)=[];%����0�ĵط�ȥ��
        %��ÿ������ÿ��AP��duty
        for j=1:length(index_s)
            index_sum=sum(index==index_s(j));%index_s()����ȡ��Ӧ��ֵ
            duties(i,index_s(j))=index_sum/max_num;
        end
    end
    fp.duties=duties;
    fps{area_i}=fp;
end

save(['data/fingerprints' data_version '.mat'],'fps');