clear
clc
load glo.mat
cd (work_path)
data_version='1';
fps=cell(1,length(area_table));
outdoor_magnetics=[28.5 -43.6];
for i=1:length(area_table)
    load (['data/' area_table{i} '/fingerprint' data_version '.mat']);
    if isfield(fp,'magnetics')
        fp.distance_center=zeros(fp.rqs_num,1);
        for j=1:fp.rqs_num
            fp.distance_center(j)=distance(fp.magnetics(j,:),outdoor_magnetics);
        end
        fp.magnitudes=sqrt(fp.magnetics(:,1).*fp.magnetics(:,1)+fp.magnetics(:,2).*fp.magnetics(:,2));
    end
    if isfield(fp,'rssis')
        rssis=cell2mat(fp.rssis);
        fp.rssi_rqs_set=cell(length(fp.bssid_map),1);
        for j=1:length(fp.bssid_map)
            fp.rssi_rqs_set{j}=rssis(:,j)~=-100;
        end
        [coef, score, latent, tsquared, explained] = pca(rssis);
        ac=cumsum(latent)./sum(latent);
        plot(1:length(latent),ac,'b*-');
        r=getError(1:length(latent),ac,0.9);
        if r<size(score,2)
            fp.rssis_pca=score(:,1:r+1);
        else
            fp.rssis_pca=score(:,1:r);
        end
        fp.rssis_coef=coef;
        fp.rssis_mean=mean(rssis,1);
        fp.rssis_r=r+1;
    end
    save (['data/' area_table{i} '/fingerprint' data_version '.mat'],'fp');
    fps{i}=fp;
end
save(['data/fingerprints' data_version '.mat'],'fps');

for i=1:length(area_table)
    if exist(['data/' area_table{i} '/testdata' data_version '.mat'],'file')
        load (['data/' area_table{i} '/testdata' data_version '.mat']);
        if isfield(td,'magnetics')
            td.distance_center=zeros(td.test_num,1);
            for j=1:td.test_num
                td.distance_center(j)=distance(td.magnetics(j,:),outdoor_magnetics);
            end
            td.magnitudes=sqrt(td.magnetics(:,1).*td.magnetics(:,1)+td.magnetics(:,2).*td.magnetics(:,2));
        end
        save (['data/' area_table{i} '/testdata' data_version '.mat'],'td');
    end
end



%         fp.magnitude_s=[0 0 0]; 
%         fp.magnitude_s(1)=getCdfError(fp.magnitudes,0.25);
%         fp.magnitude_s(2)=getCdfError(fp.magnitudes,0.50);
%         fp.magnitude_s(3)=getCdfError(fp.magnitudes,0.75);

%     if isfield(fp,'rssis')
%         rssis=cell2mat(fp.rssis);
%         fp.rssi_rqs_set=cell(length(fp.bssid_map),1);
%         for j=1:length(fp.bssid_map)
%             fp.rssi_rqs_set{j}=rssis(:,j)~=-100;
%         end
%         [coef, score, latent, tsquared, explained] = pca(rssis);
%         ac=cumsum(latent)./sum(latent);
%         plot(1:length(latent),ac,'b*-');
%         r=getError(1:length(latent),ac,0.9);
%         fp.rssis_pca=score(:,1:r+1);
%         fp.rssis_coef=coef;
%         fp.rssis_mean=mean(rssis,1);
%         fp.rssis_r=r+1;
%     end