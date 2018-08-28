% Date:     2018/08/27
% Auther:   WJK
% Function: This Script is used for analysising the effection of floor to RSS.
%           该脚本用于分析天花板对RSS的影响。
% Contact:  jiankunwang@tju.edu.cn

mh
ld
fp4=fps{1};
fp5=fps{2};
rssis4=cell2mat(fp4.rssis);
rssis5=cell2mat(fp5.rssis);
path='E:\noil\WorkSpace\Github\WiMag3\tmp\rss_map6\55-4,5';
inter_bssids=intersect(fp4.bssids,fp5.bssids);
rssi_max4=zeros(1,length(inter_bssids));
rssi_mean4=zeros(1,length(inter_bssids));
rssi_num4=zeros(1,length(inter_bssids));
rssi_max5=zeros(1,length(inter_bssids));
rssi_mean5=zeros(1,length(inter_bssids));
rssi_num5=zeros(1,length(inter_bssids));
for i=1:length(inter_bssids)
%     disp(inter_bssids{i});
    i4=fp4.bssid_map(inter_bssids{i});
    i5=fp5.bssid_map(inter_bssids{i});
    rssi4=rssis4(:,i4);
    rssi5=rssis5(:,i5);
    rssi_max4(i)=max(rssi4);
    rssi_mean4(i)=mean(rssi4);
    rssi_num4(i)=sum(rssi4>-90);
    rssi_max5(i)=max(rssi5);
    rssi_mean5(i)=mean(rssi5);
    rssi_num5(i)=sum(rssi5>-90);
end
l1=rssi_max4>rssi_max5;
l2=rssi_mean4>rssi_mean5;
l3=rssi_num4>rssi_num5;
% l12=xor(l1,l2);
% find(l12)
l13=xor(l1,l3);
find(l13)
% l23=xor(l2,l3);
% find(l23)
tmp_bssids=inter_bssids(l13);
for i=1:length(tmp_bssids)
    disp(replace(tmp_bssids{i},':','_'))
end
d_rssi=rssi_max4-rssi_max5;
newfig;
data=abs(d_rssi(d_rssi>0));
histogram(data,60);
h=plot([mean(data) mean(data)],[0 6],'r');
set(h,'linewidth',3);
ylim([0 6]);
xlim([0 60]);
figFormat(30,'RSS difference value','AP number');
title('AP at floor 4');
savegcf('tmp/floor_RSS_4',{'png'});
newfig;
data=abs(d_rssi(d_rssi<0));
histogram(data,60);
h=plot([mean(data) mean(data)],[0 6],'r');
set(h,'linewidth',3);
ylim([0 6]);
xlim([0 60]);
figFormat(30,'RSS difference value','AP number');
title('AP at floor 5');
savegcf('tmp/floor_RSS_5',{'png'});
newfig;
data=abs(d_rssi);
histogram(data,60);
h=plot([mean(data) mean(data)],[0 6],'r');
set(h,'linewidth',3);
ylim([0 6]);
xlim([0 60]);
figFormat(30,'RSS difference value','AP number');
title('AP at floor 4 and 5');
savegcf('tmp/floor_RSS',{'png'});