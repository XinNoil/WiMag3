function [ feature_mode,distance_mode,K,simulation_parameter,center_weight,is_testdata ] = get_parameters( parameters )
%GET_PARAMETERS 此处显示有关此函数的摘要
%   此处显示详细说明
feature_mode=parameters.feature_mode;
distance_mode=parameters.distance_mode;
K=parameters.K;
is_testdata=parameters.is_testdata;
if isfield(parameters,'simulation_parameter')
    simulation_parameter=parameters.simulation_parameter;
else
    simulation_parameter=0;
end
if isfield(parameters,'center_weight')
    center_weight=parameters.center_weight;
else
    center_weight=0;
end

