function fp=set_fingerprint(i_area,settings)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for creating a fingerprint.
%           该函数用于创建一个新的指纹库。
% Contact:  jiankunwang@tju.edu.cn
fp.i_area=i_area;
fp.settings=settings;
fp.area_size=0;
for i=1:length(settings)
    fp.area_size=fp.area_size+settings{i}.area_size;
end

