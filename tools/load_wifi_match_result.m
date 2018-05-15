function load_wifi_match_result(si)
    load result/result_show.mat;
    plot_floor_mark(fps{test_area}.settings);
    figFormat(15,'X','Y',[80 12]);
    set(gcf,'userdata',si);
    plot(fp.cdns(:,1),fp.cdns(:,2),'k.');
    setupdatefun(@myupdatefcn2);
    show_match_results(results(si),'WiFi');
end
