work_path = pwd;
addpath('./process');
addpath('./setting files');
addpath(genpath('./tools'));
if exist('./setting files/glo.mat','file')
    save('./setting files/glo.mat','-append','work_path')
    disp(['update work_path:' work_path]);
else
    save('./setting files/glo.mat','work_path')
    disp('warning: glo.mat not found!');
end
load glo.mat
disp(['data_version:' data_version]);
    