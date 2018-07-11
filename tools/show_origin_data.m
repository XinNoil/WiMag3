function show_origin_data(filename,type,bssid_map)
load glo.mat
load data/tmp.mat
disp(filename);
switch (type)
    case 'rssi'
        [timestamp,BSSID,RSSI,Frequency]=loadWiFiData(filename);
        bssid=unique(BSSID);
        local_bssid_indexs=zeros(1,length(bssid));
        for i=1:length(bssid)
            if(isKey(bssid_map,bssid{i}))
                local_bssid_indexs(i)=bssid_map(bssid{i});
            end
        end
        table=[num2cell(local_bssid_indexs') bssid];
        new_table=sortrows(table,1);
        
        local_bssid_indexs=cell2mat(new_table(:,1));
        bssid=new_table(:,2);
        
        row=size(timestamp,1);
        RecordsNum=max(timestamp)+1;
        local_bssid_map=containers.Map(bssid,num2cell(1:length(bssid)));
        local_ApNum=length(bssid);
        tmp_rssi=-100*ones(RecordsNum,local_ApNum);
        save_rssi=-100*ones(RecordsNum,length(fp.bssid_map));
        frequencys=containers.Map();
        for i=1:row
            frequencys(BSSID{i})=Frequency(i);
            if(isKey(local_bssid_map,BSSID(i)))
                tmp_rssi(timestamp(i)+1,local_bssid_map(cell2mat(BSSID(i))))=RSSI(i);
            end
            if(isKey(fp.bssid_map,BSSID(i)))
                save_rssi(timestamp(i)+1,fp.bssid_map(cell2mat(BSSID(i))))=RSSI(i);
            end
        end
        tmp_rssis=mean(tmp_rssi);
        file_no=input('file_no');
        save(['./tmp/rssi' n2s(file_no) '.mat'],'save_rssi','bssid');
        plotrow=floor(sqrt(length(bssid)));
        plotclo=ceil(length(bssid)/plotrow);
        figure('color','w')
        set(gcf,'outerposition',get(0,'screensize'));
        hold on;
        for i=1:length(bssid)
            subplot(plotrow,plotclo,i);
            if local_bssid_indexs(i)>0
                plot(1:RecordsNum,tmp_rssi(:,i),'r');
            else
                plot(1:RecordsNum,tmp_rssi(:,i),'b');
            end
            xlim([1 RecordsNum]);
            ylim([-100 -10]);
            figFormat(10,[n2s(local_bssid_indexs(i)) ' -- ' bssid{i} '--' n2s(frequencys(bssid{i}))],'');
        end
        save('tmp.mat','-append','bssid');
    case 'mag'
        tmp=load(filename);
        tmp=tmp(floor(size(tmp,1)/10):end-floor(size(tmp,1)/10),:);
        t=(tmp(:,2)-tmp(1,2))/1e9;
        [~,b]=min(abs(t-1));
        tmp_magnetics=tmp(:,mag_cols);
        tmp_magnetics_2d=[sqrt(tmp_magnetics(:,1).*tmp_magnetics(:,1)+tmp_magnetics(:,2).*tmp_magnetics(:,2)) tmp_magnetics(:,3)];%¶þÎ¬
        tmp_magnetics_1d=sqrt(tmp_magnetics_2d(:,1).*tmp_magnetics_2d(:,1)+tmp_magnetics_2d(:,2).*tmp_magnetics_2d(:,2));
        figure('color','w')
        subplot(3,1,1)
        hold on;
        plot(t(1:b),tmp_magnetics_2d(1:b,1),'b');
        plot(t(b:end),tmp_magnetics_2d(b:end,1),'r');
        figFormat(15,'XY','magnitude');
        subplot(3,1,2)
        hold on;
        plot(t(1:b),tmp_magnetics_2d(1:b,2),'b');
        plot(t(b:end),tmp_magnetics_2d(b:end,2),'r');
        figFormat(15,'Z','magnitude');
        subplot(3,1,3)
        hold on;
        plot(t(1:b),tmp_magnetics_1d(1:b),'b');
        plot(t(b:end),tmp_magnetics_1d(b:end),'r');
        figFormat(15,'XYZ','magnitude');
end
