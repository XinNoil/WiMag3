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
for test_area=[1 2 4 5]
    errors(test_area).name=area_table{test_area};
    parameters.test_area=test_area;
    parameters.distance_mode='E'; % E
    parameters.K=10;
    parameters.simulation_parameter=simulation_parameters(test_area); %3.16 / 4.42 / 9.36 / 5.04
    parameters.center_weight='N'; % W(距离权重)/N(无)
    parameters.feature_weight='N'; % MR(最大RSSI-权重分配)/N(无)
    parameters.bpca='N'; % Y/N 是否使用PCA降维
    parameters.binterp='N'; % 是否对指纹库进行插值
    % 2DM
    parameters.feature_mode=feature_modes{2}; % '1DM','2DM','WiFi','W1','F1'
    load(['result/' area_table{test_area} '/result' data_version '_' get_resultName(parameters)]);
    result_err=[results.result_err];
    result_err=reshape(result_err,parameters.K,length(results));
    tmp=mean(result_err,2);
    errors(test_area).mean_2DM=tmp(3);
    [XData,YData]=mycdfplot(result_err(3,:),1,'Error Distance','CDF','k','-');
    errors(test_area).per_2m_2DM=getPer(XData,YData,2);
%     disp(['80% ' n2s(getError(XData,YData,0.8)) ]);
%     disp(['90% ' n2s(getError(XData,YData,0.9)) ]);
    xlim([0 16]);
    % WiFi & F1
    parameters.feature_mode=feature_modes{5}; % '1DM','2DM','WiFi','W1','F1'
    if strcmp(parameters.feature_mode,'F1')
        parameters.predict_method=1;
        parameters.error_predict_para=error_predict_paras(test_area,:);
    end
    load(['result/' area_table{test_area} '/result' data_version '_' get_resultName(parameters)]);
    result_errs_w=[results.wifi_err];
    tmp=mean(result_errs_w);
    errors(test_area).mean_WiFi=tmp;
    [XData,YData]=mycdfplot(result_errs_w,0,'Error Distance','CDF','b','-');
    errors(test_area).per_2m_WiFi=getPer(XData,YData,2);
    result_errs_f=[results.result_errs_f];
    tmp=mean(result_errs_f,2);
    errors(test_area).mean_F1=tmp(3);
    mycdfplot(result_errs_f(3,:),0,'Error Distance','CDF','r','-');
    [XData,YData]=mycdfplot(result_errs_f(3,:),0,'Error Distance','CDF','r','-');
    errors(test_area).per_2m_F1=getPer(XData,YData,2);
    legend(gca,'location','Best','2D-Magnetic','WiFi','2D-Magnetic + WiFi');
    savegcf(['figures/' area_table{test_area} '/' area_table{test_area} 'errcdfcmp235']);
%     disp(['80% ' n2s(getError(XData,YData,0.8)) ]);
%     disp(['90% ' n2s(getError(XData,YData,0.9)) ]);
end
save data/errors235.mat errors