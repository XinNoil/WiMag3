% init
% Date:     2018/08/22
% Auther:   WJK
% Function: This is a script for preparing the environment.
%           该脚本用于准备环境。
% Contact:  jiankunwang@tju.edu.cn
%% assignment
% area table
area_table={'55-4-W','55-5-W','PARK','LIB-1-E','55-204','55-2xx','55-2-210','55-5-W-2','55-5-W-2h','55-4-E','55-4','test0','test1','55-1-E','55-5-30m'};
% is rss data exist
% RSS数据是否存在
is_rssi=[true,true,false,true,true,true,true,true,true,true,true,true,true,true,true];
% sample rate of rss fingerprints
% RSS指纹数据的采集频率
fps_rssi_freq=[5,5,0,5,1,1,1,5,5,5,5,5,5,5,5];
% sample time of rss fingerprints
% RSS指纹数据的采集时间
fps_rssi_time=[60,60,60,60,60,60,60,60,60,60,60,60,60,60,1800];
% sample time of rss testdata
% RSS指纹数据的采集时间
tds_rssi_freq=[5,5,0,5,0,0,0,0,5,5,5,5,5,5,5];
% columns of magnetic data in sensor data file(S$n$.txt)
% 传感器数据文件(S$n$.txt)中地磁数据所在列
mag_cols=[18,19,20];
%% make directory
mkdir data
mkdir figures
mkdir result
for i=1:length(area_table)
    mkdir(['data/' area_table{i}]);
    mkdir(['figures/' area_table{i}]);
    mkdir(['result/' area_table{i}]);
end
%% save glo.mat
mkdir('setting files')
save('./setting files/glo.mat')