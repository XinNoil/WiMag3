function output_txt = myupdatefcn4(obj,event_obj)
% 显示待测点的WiFi定位结果
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).
pos = get(event_obj,'Position');
    load result/tdcdns;
    no=get_No(pos,cdns);
output_txt = {['No: ' num2str(no)],...
    ['X: ',num2str(pos(1),4)],...
    ['Y: ',num2str(pos(2),4)]};
    load_wifi_match_result( no );
% If there is a Z-coordinate in the position, display it as well
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),4)];
end
