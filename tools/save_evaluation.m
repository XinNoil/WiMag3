evaluate_file='evaluation.csv';
if exist(evaluate_file,'file')
    fid=fopen(evaluate_file,'a');
else
    fid=fopen(evaluate_file,'w');
    fprintf(fid,'test_loss,max_test_loss,test_num,fp_num,data_ver,data_name,feature_mode,testResult\n');
end
fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',n2s(mean(testResult)),n2s(max(testResult)),n2s(td.num),n2s(fp.num),data_version,area_table{test_area},parameters.feature_mode,testResult_file);
fclose(fid);