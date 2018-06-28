% Date:     2017/11/23
% Auther:   WJK
% Function: This Script construct area settings
%           这是一个基于WiFi和地磁的定位算法
% Contact:  jiankunwang@tju.edu.cn

clear
% clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
sub_grid_size=5.001;
is_testdata=true; % 没有测试数据则采用测试数据从数据库中抽取。
test_area=1;
is_sub_i=false;
feature_mode=5;
feature_modes={'1DM','2DM','WiFi','W1','F1'};
simulation_parameters=[3.16 4.42 0 9.36 5.04 0 0];
error_predict_paras={
    [0.2 1.5],[0.2 1],[1 0.36],1;
    [0.2 1.6],[0.5 0.45],[0.86 0.75],1;
    [],[],[],2.4;
    [0.3 3.56],[0.45 1.15],[1.36 1.64],0;
    [0.1 2],[0.45 0.75],[0.7 1],1.5 }; % WiFi预测参数 / Dmk预测参数 / Pm预测参数 / 使用融合算法的阈值
parameters.test_area=test_area;
parameters.is_testdata=is_testdata;
parameters.is_sub_i=is_sub_i;
parameters.feature_mode=feature_modes{feature_mode}; % '1DM','2DM','WiFi','W1','F1'
parameters.distance_mode='E'; % E
parameters.K=10;
parameters.simulation_parameter=simulation_parameters(test_area); %3.16 / 4.42 / 9.36 / 5.04
parameters.center_weight='N'; % W(距离权重)/N(无)
parameters.feature_weight='N'; % MR(最大RSSI-权重分配)/N(无)
parameters.bpca='N'; % Y/N 是否使用PCA降维
parameters.binterp='N'; % 是否对指纹库进行插值
if strcmp(parameters.feature_mode,'F1')
    parameters.predict_method=1;
    parameters.error_predict_para=error_predict_paras(test_area,:);
end
i_area=WiMaG_predicate_area(test_area);
% 载入指纹库&测试集
load(['data/fingerprints' data_version '.mat']);
load(['data/fingerprints' data_version 's_' area_table{i_area} '.mat']);
if is_testdata
    load (['data/testdatas' data_version 's_' area_table{i_area} '.mat']);
end
% 运行设置
is_plot=false;
if is_plot
    plot_floor_mark(fps{i_area}.settings);
    figFormat(15,'X','Y',[80 12]);
    set(gca,'LineWidth',1,'GridLineStyle','--','GridAlpha',0);
end
sub_i_map=containers.Map(0,0);
for s_i=1:length(sub_fps)
    sub_i_map(sub_fps{s_i}.sub_i)=s_i;
    if is_testdata
        td=sub_tds{s_i};
        test_num=td.num;
    else
        test_num=sub_fps{s_i}.num;
    end
    subfp=sub_fps{s_i};
    sub_i=sub_fps{s_i}.sub_i;
    
    % 定位循环
    for i=1:test_num
        if is_testdata
            test_data=get_testdata( td,i,is_rssi(i_area),is_sub_i );
        else
            test_data=get_testdata( sub_fp{s_i},i,is_rssi(i_area),is_sub_i );
        end
        switch parameters.feature_mode
            case '1DM'
                tmp_r=WiMag_match_magni(subfp,test_data,parameters);
            case '2DM'
                tmp_r=WiMag_match_mag(subfp,test_data,parameters);
            case 'WiFi'
                tmp_r=WiMag_match_wifi(subfp,test_data,parameters);
            case 'W1'
                tmp_r=WiMag_match_rf_mag(subfp,test_data,parameters);
            case 'F1'
                tmp_r=WiMag_match_fusion(subfp,test_data,parameters);
        end
        tmp_r.test_cdns=test_data.cdn;
        tmp_r.test_data=test_data;
        if exist('results','var')
            results(end+1)=tmp_r;
        else
            results(1)=tmp_r;
        end
        if is_plot
            H=showMatchResult( tmp_r);
            if i>85
                disp([num2str(i) ':']);
            end
            clearMatchResult(H);
        end
    end
end

% result=results2result(results);
% result.parameters=parameters;
% 输出平均定位误差
if isfield(results(1),{'wifi_err'})
    mean([results.wifi_err],2)
    mycdfplot([results.wifi_err],1,'Error Distance','CDF','k','-');
end
if isfield(results(1),{'result_err'})
    result_err=[results.result_err];
    result_err=reshape(result_err,parameters.K,length(results));
    mean(result_err,2)
    [XData,YData]=mycdfplot(result_err(3,:),1,'Error Distance','CDF','k','-');
    disp(['80% ' n2s(getError(XData,YData,0.8)) ]);
    disp(['90% ' n2s(getError(XData,YData,0.9)) ]);
    xlim([0 16]);
end
if isfield(results(1),{'result_errs_f'})
    result_errs_f=[results.result_errs_f];
    mean(result_errs_f,2)
    [XData,YData]=mycdfplot(result_errs_f(3,:),0,'Error Distance','CDF','r','-');
    disp(['80% ' n2s(getError(XData,YData,0.8)) ]);
    disp(['90% ' n2s(getError(XData,YData,0.9)) ]);
    mean(abs([results.pre_err_w]))
    mean(abs([results.pre_err]))
end
if(is_sub_i)
    sub_i_list=unique([fps{i_area}.sub_i]);
    disp(['sub area errors: (K=3)']);
    for i=1:length(sub_i_list)
        tmp1=result_err(3,td.sub_i==sub_i_list(i));
        if isfield(results(1),{'result_errs_f'})
            tmp2=result_errs_f(3,td.sub_i==sub_i_list(i));
            disp(['subarea:' n2s(sub_i_list(i)) ' ,Two-stage error: ' n2s(mean(tmp1),3) ' ,Funsion error: ' n2s(mean(tmp2),3)]);
        else
            disp(['subarea:' n2s(sub_i_list(i)) ' ,Two-stage error: ' n2s(mean(tmp1),3)]);
        end
    end
end
save(['result/' area_table{test_area} '/result' data_version '_sub_' get_resultName(parameters)], 'results');
save(['data/' area_table{test_area} '/parameters.mat'],'parameters');
disp('finish');