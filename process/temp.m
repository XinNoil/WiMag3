% bssids=keys(fp.bssid_map);
% [timestamp,BSSID,RSSI,~]=loadWiFiData(fp.wfiles{1});
% indexs=get_bssid_index(fp.bssid_map,BSSID)

clear
clc
a=load('55-4-W_soft_area_predict_test_3.txt');

% num=21;
% y_pre_l=a(:,1);
% y_test=a(:,2:1+num);
% tmp=zeros(size(y_pre_l));
% for i=1:length(y_pre_l)
%     if y_test(i,y_pre_l(i)+1)>0
%         tmp(i)=1;
%     end
% end
% num=21;
% y_pre=a(:,1:num);
% y_test=a(:,1+num:2*num);
% tmp=any(y_pre&y_test,2);
% sum(tmp)/length(tmp)

num=21;
y_pre=a(:,1:num);
y_test=a(:,1+num:2*num);
[b,c]=max(y_pre,[],2);
tmp=zeros(size(y_pre,1),1);
for i=1:size(y_pre,1)
    tmp(i)=y_test(i,c(i));
end
sum(tmp)/length(tmp)