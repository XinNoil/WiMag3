function db=append_results(db,results)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for appending results.
%           该函数用于在results后增加数据。
% Contact:  jiankunwang@tju.edu.cn
result_fields=fieldnames(results);
for i=1:length(result_fields)
    eval(['db.' result_fields{i} '=[db.' result_fields{i} ';results.' result_fields{i} '];']);
end