function add_area(name)
load glo.mat area_table;
n=length(area_table);
area_table{n+1}=name;
disp(['area' n2s(n+1) ':' name]);
save glo.mat area_table
