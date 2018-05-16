function show_origin_data(filename,type,bssid_map)
load glo.mat
switch (type)
    case 'rssi'
        [timestamp,BSSID,RSSI,~]=loadWiFiData(filename);
        row=size(timestamp,1);
        RecordsNum=max(timestamp)+1;
        bssid=unique(BSSID);
        local_bssid_map=containers.Map(bssid,num2cell(1:length(bssid)));
        local_bssid_indexs=zeros(1,length(local_bssid_map));
        local_ApNum=length(bssid);
        tmp_rssi=-100*ones(RecordsNum,local_ApNum);
        for i=1:length(local_bssid_map)
            if(isKey(bssid_map,bssid{i}))
                local_bssid_indexs(i)=bssid_map(bssid{i});
            end
        end
        for i=1:row
            if(isKey(local_bssid_map,BSSID(i)))
                tmp_rssi(timestamp(i)+1,local_bssid_map(cell2mat(BSSID(i))))=RSSI(i);
            end
        end
        tmp_rssis=mean(tmp_rssi);
        plotrow=floor(sqrt(length(bssid)));
        plotclo=ceil(length(bssid)/plotrow);
        figure('color','w')
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
            legend(bssid{i},'location','Best');
            figFormat(10,'time','RSSI');
        end
    case 'mag'
        tmp=load(filename);
        tmp=tmp(floor(size(tmp,1)/10):end-floor(size(tmp,1)/10),:);
        t=(tmp(:,2)-tmp(1,2))/1e9;
        [~,b]=min(abs(t-1));
        tmp_magnetics=tmp(:,mag_cols);
        tmp_magnetics_2d=[sqrt(tmp_magnetics(:,1).*tmp_magnetics(:,1)+tmp_magnetics(:,2).*tmp_magnetics(:,2)) tmp_magnetics(:,3)];%¶þÎ¬
        tmp_magnetics_1d=sqrt(tmp_magnetics_2d(:,1).*tmp_magnetics_2d(:,1)+tmp_magnetics_2d(:,2).*tmp_magnetics_2d(:,2));
%         magnetics_rqs=tmp_magnetics(b:end,:);
%         magnetics_test=tmp_magnetics(1:b,:);
        figure('color','w')
        subplot(3,1,1)
        hold on;
        plot(t(1:b),tmp_magnetics_2d(1:b,1),'b');
        plot(t(b:end),tmp_magnetics_2d(b:end,1),'r');
        legend('XY','location','Best');
        figFormat(15,'time (s)','magnitude');
        subplot(3,1,2)
        hold on;
        plot(t(1:b),tmp_magnetics_2d(1:b,2),'b');
        plot(t(b:end),tmp_magnetics_2d(b:end,2),'r');
        legend('Z','location','Best');
        figFormat(15,'time (s)','magnitude');
        subplot(3,1,3)
        hold on;
        plot(t(1:b),tmp_magnetics_1d(1:b),'b');
        plot(t(b:end),tmp_magnetics_1d(b:end),'r');
        legend('XYZ','location','Best');
        figFormat(15,'time (s)','magnitude');
end
