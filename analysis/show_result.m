%% show_result
mh
ld
test_area=4;
fp=fps{test_area};
td=tds{test_area};
plot_floor_mark(fp.settings);
% plot(fp.cdns(:,1),fp.cdns(:,2),'r*');
% plot(td.cdns(:,1),td.cdns(:,2),'b*');

filename='tmp/R_m_DNN-0_d_0.2_e_20_b_16_testResult.txt';
result_data=load(filename);
test_cdns=result_data(:,4:5);
predict_cdns=result_data(:,2:3);
[cdn_max,cdn_min]=get_cdns_statics(test_area);
test_cdns=test_cdns+cdn_min;
predict_cdns=predict_cdns+cdn_min;
l=test_cdns(:,1)>13;
plot(test_cdns(l,1),test_cdns(l,2),'ro');
plot(predict_cdns(l,1),predict_cdns(l,2),'bo');
