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
fps{4}.rssi_mask=rssi_mask;
save(['data/fingerprints' data_version '.mat'],'fps');
save tmp/wimag.mat 
WiMag3
mycdfplot(testResult,1,'Error Distance','CDF','r','-',[0 15],0:3:15);
load tmp/wimag.mat