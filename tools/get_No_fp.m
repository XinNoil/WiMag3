function no = get_No_fp( pos )
%GET_NO �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
load tmp/fpcdns.mat
a=find(fpcdns(:,1)==pos(1));
b=find(fpcdns(:,2)==pos(2));
no=intersect(a,b);
if(length(no)>1)
    disp('Error');
    exit;
end
end

