function load_match_result( si )
%LOADMATCHRESULT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    load result/result_show.mat;
    plot_floor_mark(fps{test_area}.settings);
    figFormat(15,'X','Y',[80 12]);
    set(gcf,'userdata',si);
    plot(fp.cdns(:,1),fp.cdns(:,2),'k.');
    setupdatefun(@myupdatefcn2);
%     str=['Distance to Center: ' num2str(fp.distance_center(si))];
    str=['Dk: ' n2s(results(si).avgpd_k(3))];
    show_match_result(results(si),str);
end

