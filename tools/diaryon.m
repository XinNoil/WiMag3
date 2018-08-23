% diaryon
% Date:     2018/07/14
% Auther:   WJK
% Function: This is a diary file checking script for process_origin_data.
%           这是process_origin_data脚本的日志文件检查脚本。
% Contact:  jiankunwang@tju.edu.cn
if exist(diary_filename,'file')
    disp(['Diary : setting files/process_origin/' area_table{i_area} '.txt deleted']);
    delete(diary_filename);
end
disp(['Diary : setting files/process_origin/' area_table{i_area} '.txt created']);
diary(['setting files/process_origin/' area_table{i_area} '.txt']);
diary on;
disp(' ');