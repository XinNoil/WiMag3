function [ feature_mode,distance_mode,K,simulation_parameter,center_weight ] = get_parameters( parameters )
%GET_PARAMETERS 此处显示有关此函数的摘要
%   此处显示详细说明
feature_mode=parameters.feature_mode; % 1DM/2DM/S1
distance_mode=parameters.distance_mode; % E
K=parameters.K;
simulation_parameter=parameters.simulation_parameter;
center_weight=parameters.center_weight; % W/N

end

