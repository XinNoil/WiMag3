function no = get_No_fp( pos )
%GET_NO 此处显示有关此函数的摘要
%   此处显示详细说明
load tmp/fpcdns.mat
a=find(fpcdns(:,1)==pos(1));
b=find(fpcdns(:,2)==pos(2));
no=intersect(a,b);
if(length(no)>1)
    disp('Error');
    exit;
end
end

