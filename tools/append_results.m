function db=append_results(db,results)
result_fields=fieldnames(results);
for i=1:length(result_fields)
    eval(['db.' result_fields{i} '=[db.' result_fields{i} ';results.' result_fields{i} '];']);
end