function save_json(filename,data)
json=jsonencode(data);
fid = fopen(filename, 'w');
fprintf(fid,'%s',json); 
fclose(fid);