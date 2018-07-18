% Date:     2018/7/1
% Auther:   WJK
% Function: 这是一个分析区域软划分下区域预测情况的程序。
% Contact:  jiankunwang@tju.edu.cn
%% 
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);
load(['data/testdatas' data_version '.mat']);
areas=1:length(area_table);
show_type='rssi';

area_num=21;
filename='data_new/result/area_predict/all/55-4-W_soft0_area_predict_testResult.txt';
data=load(filename);
y_pre=data(:,1:area_num);
y_test=data(:,1+area_num:2*area_num);

filename='data_new/result/area_predict/all/55-4-W_soft0_area_predict_testResult.txt';
% data=load(filename);
% y_pre=data(:,6:area_num+5);
% y_test=data(:,6+area_num:5+2*area_num);
% loss=data(:,1);

save tmp/data.mat data
remove_no=[];
%%
for area_i=1%[1 2 4 5] % areas
    fp=fps{area_i};
    td=tds{area_i};
    fpcdns=fp.cdns;
    tdcdns=td.cdns;
    save tmp/tmp.mat td fp fpcdns tdcdns show_type
    
    area_num=length(fp.area_vertexs);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns=data(:,end-1:end)+cdn_min;
    load tmp/data.mat;
    
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    
    [b,c]=sort(y_pre,2,'descend');
    max_b=max(b,[],2);
    bb=b./max_b;
    tmp=zeros(size(y_pre,1),1);
    for i=1:size(y_pre,1)
        tmp(i)=y_test(i,c(i,1));
    end
%     mycdfplot(bb(~~tmp,2),1,'Ratio','CDF');
%     mycdfplot(bb(~tmp,2),0,'Ratio','CDF','r','-',[0 1],0:0.2:1);
%     legend('Correct prediction','Incorrect prediction','location','Southeast');
%     savegcf('./figures/area_predict_analysis/ratio2-1');
%     mycdfplot(bb(~~tmp,3),1,'Ratio','CDF');
%     mycdfplot(bb(~tmp,3),0,'Ratio','CDF','r','-',[0 1],0:0.2:1);
%     legend('Correct prediction','Incorrect prediction','location','Southeast');
%     savegcf('./figures/area_predict_analysis/ratio3-1');
%     mycdfplot(bb(~~tmp,3)./bb(~~tmp,2),1,'Ratio','CDF');
%     mycdfplot(bb(~tmp,3)./bb(~tmp,2),0,'Ratio','CDF','r','-',[0 1],0:0.2:1);
%     legend('Correct prediction','Incorrect prediction','location','Southeast');
%     savegcf('./figures/area_predict_analysis/ratio3-2');
    disp(sum(tmp)/length(tmp))
%     error_loss=loss(~tmp);
%     cdfappend(error_loss);
    error_cdns=cdns(~tmp,:);
    error_c=c(~tmp,1);
    error_d=c(~tmp,2);
    error_y_pre=y_pre(~tmp,:);
    error_y_test=y_test(~tmp,:);
    unique_cdns=unique(error_cdns,'rows');
    tmp_no=zeros(size(unique_cdns,1),1);
    for i=1:size(unique_cdns,1)
        tmp_no(i)=get_No(unique_cdns(i,:),td.cdns);
    end
    nos{area_i}=tmp_no;
    %% 循环
    for i=1:size(unique_cdns,1)
        tmp_cdn=unique_cdns(i,:);
        tmp_mask=all(error_cdns==tmp_cdn,2);
        tmp_c=error_c(tmp_mask);
        tmp_d=error_d(tmp_mask);
        tmp_y_test=error_y_test(tmp_mask,:);
        area_codes=find(tmp_y_test(1,:)==1);
        plot_floor_mark(fp.settings);
        plot_floor_sub(fp.area_vertexs,area_codes,'b');
        plot_floor_sub(fp.area_vertexs,unique(tmp_d),'r','--');
        plot_floor_sub(fp.area_vertexs,unique(tmp_c),'r');
        
        h=plot(tmp_cdn(1),tmp_cdn(2),'bo');
        set(h,'MarkerSize',10,'MarkerFaceColor','b')
        title(['td No:' n2s(tmp_no(i)) ' cdn: ' n2s(tmp_cdn(1)) ' ' n2s(tmp_cdn(2))]);
        plot(fpcdns(:,1),fpcdns(:,2),'r*');
        savegcf(['./data_new/figures/area_predict_analysis2/' area_table{area_i} '_' n2s(i)],{'png'});
        setupdatefun(@myupdatefcn3);
        if min(abs(tmp_c(1)-area_codes))>2
            remove_no(end+1)=tmp_no(i);
        end
        close;
    end
    save tmp/tmp_no.mat tmp_no
end


