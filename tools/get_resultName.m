function resultName = get_resultName( parameters )
%GET_RESULTNAME 此处显示有关此函数的摘要
%   此处显示详细说明
    feature_mode=parameters.feature_mode;
    distance_mode=parameters.distance_mode;
    simulation_parameter=parameters.simulation_parameter;
    center_weight=parameters.center_weight;
    resultName=[feature_mode distance_mode num2str(simulation_parameter) center_weight '.mat'];
end

