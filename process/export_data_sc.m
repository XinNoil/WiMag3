% Date:     2018/5/22
% Auther:   WJK
% Function: The script extracts fingerprints from several sub-regions
%           该脚本将若干子区域的指纹库提取出来
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
areas=[1 2 4 5];
sub_grid_size=5.001; % 子区域大小
is_overlapped=false;
mag_cols=18:20;
test_time=2;

% 载入数据
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);

% 
for area_i=areas
    % train
    fp=fps{area_i};
    [mag_max,mag_min]=get_magnetic_statics(area_i);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns=fp.cdns;
    labels=cdns-cdn_min;
    rssis=cell2mat(fp.rssis);
    rssis=(rssis+100)/70;
    rssis(rssis<0)=0;
    rssis(rssis>1)=1;
    magnetics=my_norm(fp.magnetics,mag_max,mag_min);
    rqs_feature=[magnetics rssis];
    rqs_num=fp.num;
    rqs_features=zeros(rqs_num,rqs_num*size(rqs_feature,2));
    for i=1:rqs_num
        tmp=rqs_feature-rqs_feature(i,:);
        rqs_features(i,:)=tmp(:)';
    end
    rqs_features=(rqs_features+1)/2;
    train_m=[labels rqs_features];
    disp(['data_new/' area_table{area_i} '_sc_training.csv']);
    csvwrite(['data_new/' area_table{area_i} '_sc_training.csv'],train_m);
    
    % test
    td=tds{area_i};
    tdcdns=td.cdns;
    labels=tdcdns-cdn_min;
    rssis=cell2mat(td.rssis);
    rssis=(rssis+100)/70;
    rssis(rssis<0)=0;
    rssis(rssis>1)=1;
    magnetics=my_norm(td.magnetics,mag_max,mag_min);
    td_feature=[magnetics rssis];
    td_features=zeros(td.num,rqs_num*size(rqs_feature,2));
    for i=1:td.num
        tmp=rqs_feature-td_feature(i,:);
        td_features(i,:)=tmp(:)';
    end
    test_m=[labels td_features];
    disp(['data_new/' area_table{area_i} '_sc_testing.csv']);
    csvwrite(['data_new/' area_table{area_i} '_sc_testing.csv'],test_m);
end