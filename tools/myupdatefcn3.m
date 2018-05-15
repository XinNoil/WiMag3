function output_txt = myupdatefcn3(obj,event_obj)
% 显示参考点或者待测点的磁场指纹
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).
pos = get(event_obj,'Position');
    load data/tmp.mat
    no=get_No(pos,fpcdns);
    if isempty(no)
        no=get_No(pos,tdcdns);
        output_txt = {['Test No: ' num2str(no)],...
    ['X: ',num2str(pos(1),4)],...
    ['Y: ',num2str(pos(2),4)],...
    ['H:' n2s(td.magnetics(no,1)) '  V:' n2s(td.magnetics(no,2))]};
    else
        output_txt = {['Rqs No: ' num2str(no)],...
    ['X: ',num2str(pos(1),4)],...
    ['Y: ',num2str(pos(2),4)],...
    ['H:' n2s(fp.magnetics(no,1)) '  V:' n2s(fp.magnetics(no,2))]};
    end
% If there is a Z-coordinate in the position, display it as well
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),4)];
end
