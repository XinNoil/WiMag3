function tmp_magnetic=process_magnetic(filename,RecordsNum,mag_cols,test_time)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for processing origin magnetic data file.
%           该函数用于处理一个原始地磁数据文件。
% Contact:  jiankunwang@tju.edu.cn
tmp=load(filename);
tmp=tmp(floor(size(tmp,1)/10):end-floor(size(tmp,1)/10),:);
t=abs((tmp(:,2)-tmp(1,2))/10e8-test_time);
[~,b]=min(t);
tmp_magnetics=tmp(:,mag_cols);
tmp_magnetics=[sqrt(tmp_magnetics(:,1).*tmp_magnetics(:,1)+tmp_magnetics(:,2).*tmp_magnetics(:,2)) tmp_magnetics(:,3)];%二维
tmp_magnetics=tmp_magnetics(b:end,:);
t_tmp=t(b:end);
t_b=t_tmp(1);
t_e=t_tmp(end);
tt=(t_e-t_b)/(RecordsNum-1);
tmp_magnetic=zeros(RecordsNum,2);
for i=1:RecordsNum
    tmp_b=t_b+(i-1.5)*tt;
    tmp_e=t_b+(i-0.5)*tt;
    mask=t_tmp>=tmp_b;
    mask=mask&(t_tmp<=tmp_e);
    if(sum(mask)>0)
        tmp_magnetic(i,:)=mean(tmp_magnetics(mask,:),1);
    else
        tmp_magnetic(i,:)=tmp_magnetic(i-1,:);
    end
end