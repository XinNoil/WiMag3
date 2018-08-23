% Date:     2017/11/23
% Auther:   WJK
% Function: 这是一个基于WiFi和地磁的定位算法。  
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
%% 参数设置
run_this=false;
if run_this
    test_area=1;
    feature_mode=5;
else
    load tmp/wimag.mat test_area feature_mode;
end
feature_modes={'M','MM','R','RM','RMM'};
remove_no=[];
is_testdata=true; % 没有测试数据则采用测试数据从数据库中抽取。
is_plot=false;
parameters.test_area=test_area;
parameters.is_testdata=is_testdata;
parameters.feature_mode=feature_modes{feature_mode};
parameters.distance_mode='E'; % E
parameters.K=3;
i_area=WiMaG_predicate_area(test_area);
disp(area_table{test_area});
disp(parameters.feature_mode);
%% 载入指纹库&测试集
load(['data/fingerprints' data_version '.mat']);
fp=fps{i_area};
if isfield(fp,'rssi_mask')
    parameters.rssi_mask=fp.rssi_mask;
else
    parameters.rssi_mask=true(1,length(fp.bssid_map));
end
[mag_max,mag_min]=get_magnetic_statics(i_area,2);
fp.mag_max=mag_max;
fp.mag_min=mag_min;
fp.magni_max=max(fp.magnitudes);
fp.magni_min=min(fp.magnitudes);
if is_testdata
    load (['data/testdatas' data_version '.mat']);
    td=tds{test_area};
    test_num=td.num;
else
    test_num=fp.num;
end
if is_plot
    plot_floor_mark(fp.settings);
    figFormat(15,'X','Y',[80 12]);
    set(gca,'LineWidth',1,'GridLineStyle','--','GridAlpha',0);
end
diary('tmp/diary.txt');
diary on;
%% 定位循环
td_no=1:td.num;
td_no(remove_no)=[];
for i=1:length(td_no)
    ti=td_no(i);
    if is_testdata
        test_data=get_testdata( td,ti,is_rssi(i_area),false,parameters.rssi_mask );
    else
        test_data=get_testdata( fp,ti,is_rssi(i_area),false,parameters.rssi_mask );
    end
    tmp_r=WiMag_match(fp,test_data,parameters);
    results(i)=tmp_r;
    if is_plot
        H=showMatchResult( tmp_r);
        clearMatchResult(H);
    end
end
testResult=[results.result_err]';
disp(['mean error: ' n2s(mean(testResult))]);
if run_this
    mycdfplot(testResult,1,'Error Distance','CDF','r','-');
end
%% save result
% save(['result/' area_table{test_area} '/result' data_version '_' get_result_name(parameters)], 'results');
testResult_file=['testResults/0_' area_table{test_area} '/KNN_v_' data_version '_' get_result_name(parameters) '_testResult.txt'];
if ~exist(['testResults/0_' area_table{test_area}],'dir')
    mkdir(['testResults/0_' area_table{test_area}]);
end
save(testResult_file,'testResult','-ascii', '-double');
save(['data/' area_table{test_area} '/parameters.mat'],'parameters');
save_evaluation;
disp('finish');
diary off;