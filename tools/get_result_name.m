function resultName = get_result_name(parameters)
    feature_mode=parameters.feature_mode;
    distance_mode=parameters.distance_mode;
    resultName=[feature_mode '_' distance_mode];
end

