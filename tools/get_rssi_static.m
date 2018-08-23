function rssi_static=get_rssi_static(tmp_rssi)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for getting wifi statics.
%           �ú������ڻ�ȡWiFi��ͳ�����ݡ�
% Contact:  jiankunwang@tju.edu.cn
ApNum=size(tmp_rssi,2);
rssi_static.duties=zeros(1,ApNum);
rssi_static.means=ones(1,ApNum).*-100;
rssi_static.stds=zeros(1,ApNum);
g_cols=find(mean(tmp_rssi,1)>-100);
for c=g_cols
    tmp_col=tmp_rssi(:,c);
    tmp_col(tmp_col==-100)=[];
    tmp_mean=mean(tmp_col);
    tmp_std=std(tmp_col);
    rssi_static.duties(c)=sum(tmp_col>-100)/size(tmp_rssi,1);
    rssi_static.means(c)=tmp_mean;
    rssi_static.stds(c)=tmp_std;
end