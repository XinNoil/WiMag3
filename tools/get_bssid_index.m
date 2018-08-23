function indexs=get_bssid_index(bssid_map,bssids)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for getting index of a bssid in bssid_maps.
%           该函数用于获取一个bssid在bssid_maps中的序号。
% Contact:  jiankunwang@tju.edu.cn
indexs=zeros(1,length(bssids));
for i=1:length(bssids)
    if(isKey(bssid_map,bssids{i}))
        indexs(i)=bssid_map(bssids{i});
    end
end