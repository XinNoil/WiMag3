clear
clc
load glo.mat
cd (work_path)
data_version='1';
fps=cell(1,length(area_table));
tds=cell(1,length(area_table));
dbs=cell(1,length(area_table));
outdoor_magnetics=[28.5 -43.6];
for i=1:length(area_table)
    load (['data/' area_table{i} '/fingerprint' data_version '.mat']);
    fp=before_save(fp,outdoor_magnetics);
    save (['data/' area_table{i} '/fingerprint' data_version '.mat'],'fp');
    fps{i}=fp;
    
    if(exist(['data/' area_table{i} '/testdata' data_version '.mat'],'file'))
        load (['data/' area_table{i} '/testdata' data_version '.mat']);
        td=before_save(td,outdoor_magnetics);
        save(['data/' area_table{i} '/testdata' data_version '.mat'],'td');
    end
    
    load (['data/' area_table{i} '/database' data_version '.mat']);
    db=before_save(db,outdoor_magnetics);
    save (['data/' area_table{i} '/database' data_version '.mat'],'db');
    dbs{i}=db;
    
end
save(['data/fingerprints' data_version '.mat'],'fps');
save(['data/testdatas' data_version '.mat'],'tds');
save(['data/databases' data_version '.mat'],'dbs');