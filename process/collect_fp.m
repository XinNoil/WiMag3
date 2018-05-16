clear
clc
load glo.mat
cd (work_path)
data_version='1';
fps=cell(1,length(area_table));
outdoor_magnetics=[28.5 -43.6];
for i=1:length(area_table)
    load (['data/' area_table{i} '/fingerprint' data_version '.mat']);
    fp=before_save(fp,outdoor_magnetics);
    save (['data/' area_table{i} '/fingerprint' data_version '.mat'],'fp');
    fps{i}=fp;
end
save(['data/fingerprints' data_version '.mat'],'fps');