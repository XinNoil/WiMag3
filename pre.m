work_path = pwd;
addpath('./process');
addpath('./setting files');
addpath(genpath('./tools'));
save('glo.mat','-append','work_path')