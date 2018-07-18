clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
% ‘ÿ»Î÷∏Œ∆ø‚&≤‚ ‘ºØ
load(['data/fingerprints' data_version '.mat']);
load(['data/testdatas' data_version '.mat']);
cq='rgbcmkrgbcmkrgbcmkrgbcmkrgbcmk';
mq='oooooo^^^^^^ssssssppppppvvvvvv';
opts = statset('Display','final');
areas=[1 2 4 5 10 11];

%% train KNN Classification
for area_i=areas
    fp=fps{area_i};
    if isfield(fp,'rssis')
        train_data=cell2mat(fp.rssis);
        train_label=fp.kclass;
        fp.classifier = ClassificationKNN.fit(train_data,train_label,'NumNeighbors',3);
%         save(['data/' area_table{area_i} '/classifier.mat'],'mdl');
    end
    fps{area_i}=fp;
end
 save(['data/fingerprints' data_version '.mat'],'fps');

%% test KNN Classification
for area_i=areas
    fp=fps{area_i};
    td=tds{area_i};
    if isfield(fp,'rssis')
        test_data=cell2mat(td.rssis);
        test_label=predict(fp.classifier, test_data);
        td.kclass=test_label;
    end
    tds{area_i}=td;
end
 save(['data/fingerprints' data_version '.mat'],'fps');
% save(['data/fingerprints' data_version '.mat'],'fps');