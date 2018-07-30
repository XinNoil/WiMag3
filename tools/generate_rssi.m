function new_rssi=generate_rssi(tmp_rssi,gsize)
new_rssi=ones(gsize,size(tmp_rssi,2)).*-100;
g_cols=find(mean(tmp_rssi,1)>-100);
for c=g_cols
    tmp_col=tmp_rssi(:,c);
    tmp_gsize=ceil(sum(tmp_col>-100)/size(tmp_rssi,1)*gsize);
    tmp_col(tmp_col==-100)=[];
    tmp_mean=mean(tmp_col);
    tmp_std=std(tmp_col);
    new_col=ones(1,gsize).*-100;
    new_col(1:tmp_gsize)=normrnd(tmp_mean,tmp_std,[1,tmp_gsize]);
    randIndex = randperm(gsize);
    new_col=new_col(randIndex);
    new_rssi(:,c)=new_col;
end
