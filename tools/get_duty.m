function duty=get_duty(timestamp,BSSID,bssid_map)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for getting all ap's wifi duty(loss rate) of a time sequence.
%           该函数用于计算一个时间序列中所有AP的占空比（丢失率）。
% Contact:  jiankunwang@tju.edu.cn
duty=zeros(1,length(bssid_map));
BSSIDs=unique(BSSID);
max_num=max(timestamp)+1;
index_s=get_bssid_index(bssid_map,BSSIDs);
index=get_bssid_index(bssid_map,BSSID);%所有BSSID对应的编号
index_s(index_s==0)=[];%把是0的地方去掉
%求每个点上每个AP的duty
for j=1:length(index_s)
    index_sum=sum(index==index_s(j));%index_s()就是取对应的值
    duty(index_s(j))=index_sum/max_num;
end