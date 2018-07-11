clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);
load(['data/testdatas' data_version '.mat']);
show_type='all';
sub_grid_size=5.001;
areas=1:length(area_table);
for area_i=[1 2 4 5] % areas
    fp=fps{area_i};
    td=tds{area_i};
    tdcdns=td.cdns;
    save tmp.mat;
    count=zeros(td.num,1);
    acc=zeros(td.num,1);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    dirpath=['./data/0-Deep-Area/'];
    data=load([dirpath area_table{area_i} '_s0_predic_test_0.txt']);
    cdns=cdn_min+data(:,3:4);
    y_predict=data(:,1);
    y_test=data(:,2);
    for i=1:size(cdns,1)
        tmp_i = get_No(cdns(i,:),tdcdns);
        count(tmp_i)=count(tmp_i)+1;
        if y_predict(i)==y_test(i)
            acc(tmp_i)=acc(tmp_i)+1;
        end
    end
    accs=y_predict==y_test;
    disp([area_table{area_i} ' ' n2s(sum(accs)/length(accs))]);
    plot_floor_mark(fp.settings,tdcdns,acc./count,true,true,sub_grid_size);
    settings=fp.settings;
    title([area_table{area_i} ', acc: ' n2s(sum(accs)/length(accs))]);
%     savegcf(['./figures/' area_table{area_i} '_area_predict']);
end

