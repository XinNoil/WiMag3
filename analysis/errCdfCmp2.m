clear
clc
load glo.mat
cd (work_path)
% 参数设置
data_version='1';
feature_modes={'1DM','2DM','WiFi','W1','F1'};
simulation_parameters=[3.16 4.42 0 9.36 5.04];
error_predict_paras={
    [0.2 1.5],[0.2 1],[1 0.36],1;
    [0.2 1.6],[0.5 0.45],[0.86 0.75],1;
    [],[],[],2.4;
    [0.3 3.56],[0.45 1.15],[1.36 1.64],0;
    [0.1 2],[0.45 0.75],[0.7 1],1.5 }; % WiFi预测参数 / Dmk预测参数 / Pm预测参数 / 使用融合算法的阈值
for test_area=3
    errors(test_area).name=area_table{test_area};
    parameters.test_area=test_area;
    parameters.distance_mode='E'; % E
    parameters.K=10;
    parameters.simulation_parameter=simulation_parameters(test_area); %3.16 / 4.42 / 9.36 / 5.04
    parameters.center_weight='N'; % W(距离权重)/N(无)
    parameters.feature_weight='N'; % MR(最大RSSI-权重分配)/N(无)
    parameters.bpca='N'; % Y/N 是否使用PCA降维
    parameters.binterp='N'; % 是否对指纹库进行插值
    % 1DM
    parameters.feature_mode=feature_modes{1}; % '1DM','2DM','WiFi','W1','F1'
    load(['result/' area_table{test_area} '/result' data_version '_' get_resultName(parameters)]);
    result_err=[results.result_err];
    result_err=reshape(result_err,parameters.K,length(results));
    tmp=mean(result_err,2);
    [XData,YData]=mycdfplot(result_err(3,:),1,'Error Distance','CDF','b','-');
    errors(test_area).mean_1DM=tmp(3);
     % 2DM
    parameters.feature_mode=feature_modes{2}; % '1DM','2DM','WiFi','W1','F1'
    load(['result/' area_table{test_area} '/result' data_version '_' get_resultName(parameters)]);
    result_err=[results.result_err];
    result_err=reshape(result_err,parameters.K,length(results));
    tmp=mean(result_err,2);
    [XData,YData]=mycdfplot(result_err(3,:),0,'Error Distance','CDF','r','-');
    errors(test_area).mean_2DM=tmp(3);
    legend(gca,'location','Best','1D-Magnetic','2D-Magnetic');
    savegcf(['figures/' area_table{test_area} '/' area_table{test_area} 'errcdfcmp12']);
end
save data/errors12.mat errors