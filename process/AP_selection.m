% Date:     2018/08/30
% Auther:   WJK
% Function: This Script select APs by loss rate.
%           该脚本基于Loss rate筛选AP。
% Contact:  jiankunwang@tju.edu.cn

mh
ld
show_type='losscdf'; % rssi/loss
save_path=[show_type data_version];
% areas=1:length(area_table);
areas=[1 2 4 5 10 14];
per_low_losses=cell(1,length(area_table));
colorqueue='kbrmgc';
newfig;
for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    if ~isfield(fp,'rssi_statics')
        continue;
    end
    duties=[fp.rssi_statics.duties];
    loss_rates=1-reshape(duties,fp.ap_num,fp.num);
    bssid_map_r=get_map_reverse(fp.bssid_map);
    show_rssis_map_checkdir;
    per_low_loss=zeros(1,fp.ap_num);
    for a=1:fp.ap_num
        loss_rate=loss_rates(a,:);
        loss_rate=loss_rate(loss_rate<1);
        per_low_loss(a)=sum(loss_rate<0.1)./length(loss_rate);
%         mycdfplot(loss_rate,1,'Loss rate','CDF','b','-',[0 1],0:0.2:1);
%         bssid=bssid_map_r(a);
%         title([bssid_map_r(a) ' ' n2s(fp.bssids_freq(a)) ' ' n2s(a)]);
%         savegcf(['./tmp/' save_path '/' area_table{area_i} '/' replace(bssid,':','_') '_' n2s(fp.bssids_freq(a)) '_' n2s(a)],{'png'});
    end
    fp.per_low_loss=per_low_loss;
    per_low_loss=per_low_loss(fp.rssi_mask);
    per_low_losses{area_i}=per_low_loss;
    mycdfplot(per_low_loss,0,'Percentage of low loss rate of AP',[],colorqueue(i),[],[0 1],0:0.2:1);
%     savegcf(['./tmp/' save_path '/' area_table{area_i} 'per_low_rate_cdf'],{'png'});
    fps{area_i}=fp;
end
set(gca,'xticklabel',{'0%','20%','40%','60%','80%','100%'});
legend(area_table(areas));
savegcf(['./tmp/' save_path '/per_low_rate_cdf'],{'png'});
save(['data/fingerprints' data_version '.mat'],'fps');
per_low_loss=per_low_losses{4};
per_thredhold=[0 0.05 0.10 0.15 0.20 0.40];
for p=per_thredhold
    disp(sum(per_low_loss>=p))
end