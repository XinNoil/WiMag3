% LIB
% Date:     2018/08/23
% Auther:   WJK
% Function: This Script.
%           该脚本用于分析图书馆的数据。
% Contact:  jiankunwang@tju.edu.cn

%% backup rssi_mask
% mh
% ld
% fps{4}.rssi_mask_b=fps{4}.rssi_mask;
% save(['data/fingerprints' data_version '.mat'],'fps');
%% change default rss
% mh
% ld
% feature_modes={'M','MM','R','RM','RMM'};
% test_area=4;
% feature_mode=3;
% parameters.test_area=test_area;
% parameters.is_testdata=true;
% parameters.feature_mode=feature_modes{feature_mode};
% parameters.distance_mode='E'; % E
% parameters.K=3;
% parameters.max_rssi=-20;
% rssi_hold=-60:-5:-100;
% lib_result_errors=zeros(1,length(rssi_hold));
% lib_result_files=cell(1,length(rssi_hold));
% save tmp/lib.mat lib_result_errors lib_result_files
% for ri=1:length(rssi_hold)
%     fp=fps{4};
%     max_rssi=max(cell2mat(fp.rssis));
%     rssi_mask=max_rssi>rssi_hold(ri);
%     fp.rssi_mask=fp.rssi_mask_b&rssi_mask;
%     fps{4}=fp;
%     save(['data/fingerprints' data_version '.mat'],'fps');
%     parameters.min_rssi=rssi_hold(ri);
%     parameters.result_label=n2s(ri);
%     save tmp/wimag.mat 
%     WiMag3
% %     mycdfplot(testResult,1,'Error Distance','CDF','r','-',[0 15],0:3:15);
%     load tmp/wimag.mat
%     load tmp/lib.mat
%     lib_result_errors(ri)=mean(testResult);
%     lib_result_files{ri}=testResult_file;
%     save tmp/lib.mat lib_result_errors lib_result_files
%     clear
%     load tmp/wimag.mat
% end
% clear
%% plot
% load tmp/lib.mat
% rssi_hold=-60:-5:-100;
% newfig;
% h=plot(rssi_hold,lib_result_errors);
% set(h,'linewidth',3);
% figFormat(30,'Default RSS value','Mean distance error of RADAR (m)');
%%
mh
ld
feature_modes={'M','MM','R','RM','RMM'};
test_area=4;
feature_mode=3;
parameters.test_area=test_area;
parameters.is_testdata=true;
parameters.feature_mode=feature_modes{feature_mode};
parameters.distance_mode='E'; % E
parameters.K=3;
parameters.max_rssi=-20;
parameters.min_rssi=-85;
load tmp/rssi_mask.mat
fps{4}.rssi_mask=rssi_mask;
save(['data/fingerprints' data_version '.mat'],'fps');
save tmp/wimag.mat 
WiMag3
mycdfplot(testResult,1,'Error Distance','CDF','r','-',[0 15],0:3:15);
load tmp/wimag.mat