if exist(diary_filename,'file')
    disp(['Diary : setting files/process_origin/' area_table{i_area} '.txt deleted']);
    delete(diary_filename);
end
disp(['Diary : setting files/process_origin/' area_table{i_area} '.txt created']);
diary(['setting files/process_origin/' area_table{i_area} '.txt']);
diary on;
disp(' ');