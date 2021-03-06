clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
fps=cell(1,length(area_table));
tds=cell(1,length(area_table));
dbs=cell(1,length(area_table));
is_pca=false;
thredhold=-100;
warning off
outdoor_magnetics=[28.5 -43.6];
for i=1:length(area_table)
    if(exist(['data/' area_table{i} '/testdata' data_version '.mat'],'file'))
        load (['data/' area_table{i} '/testdata' data_version '.mat']);
        td=rssi_threshold(td,thredhold);
        td=rssi_pca(td);
        tds{i}=td;
    end
    
    if(exist(['data/' area_table{i} '/fingerprint' data_version '.mat'],'file'))
        load (['data/' area_table{i} '/fingerprint' data_version '.mat']);
        fp=rssi_threshold(fp,thredhold);
        fp=rssi_pca(fp);
        fp=rm_field(fp,'rssi_mask');
        fp=set_rssi_mask(fp,tds{i},is_rssi(i));
        fps{i}=fp;
    end
    
    if(exist(['data/' area_table{i} '/database' data_version '.mat'],'file'))
        load (['data/' area_table{i} '/database' data_version '.mat']);
        db=rssi_threshold(db,thredhold);
        db=rssi_pca(db);
        dbs{i}=db;
    end
end
save(['data/fingerprints' data_version '.mat'],'fps');
save(['data/testdatas' data_version '.mat'],'tds');
save(['data/databases' data_version '.mat'],'dbs');
warning on