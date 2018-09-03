function tmp_rssi=process_wifi_o(filename,bssid_map,type,freq,test_time)
% Date:     2018/08/29
% Auther:   WJK
% Function: This function is used for processing origin wifi data file with ignoring the unreceived value.
%           �ú������ڴ���һ��WiFi�����ļ���ԭʼ���ݣ�������û���յ���RSS��
% Contact:  jiankunwang@tju.edu.cn
% �ο���ȡ2:end-test_time������ݣ����Ե�ȡend-test_time�������:end�������
[timestamp,BSSID,RSSI,~]=loadWiFiData(filename);
% if freq>0
%     if type=='0' %�ο���
%         mask=timestamp>2*freq&timestamp<(max(timestamp)-test_time*freq+1);
%     else
%         mask=timestamp>max(timestamp)-test_time*freq;
%     end
%     timestamp=timestamp(mask);
%     timestamp=timestamp-min(timestamp);
%     BSSID=BSSID(mask);
%     RSSI=RSSI(mask);
% else
%     mask=timestamp<5;
%     timestamp=timestamp(mask);
%     timestamp=timestamp-min(timestamp);
%     BSSID=BSSID(mask);
%     RSSI=RSSI(mask);
% end
row=size(timestamp,1);
bssid=unique(BSSID);
ApNum=length(bssid_map);
tmp_rssi=-100*ones(1,ApNum);
tmp_rssis=cell(1,ApNum);
for i=1:row
    if(isKey(bssid_map,BSSID(i)))
        tmp=tmp_rssis{1,bssid_map(cell2mat(BSSID(i)))};
        tmp_rssis{1,bssid_map(cell2mat(BSSID(i)))}=[tmp RSSI(i)];
    end
end
for j=1:ApNum
    if ~isempty(tmp_rssis{j})
        tmp_rssi(j)=mean(tmp_rssis{j});
    end
end