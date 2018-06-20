function ch_data_version(i)
data_version=n2s(i);
save('glo.mat','-append','data_version');
