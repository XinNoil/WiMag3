function no = get_No( pos,cdns )
%GET_NO �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
a=find(abs(cdns(:,1)-pos(1))<1e-5);
b=find(abs(cdns(:,2)-pos(2))<1e-5);
no=intersect(a,b);
if(length(no)>1)
    disp('Error');
    exit;
end
end

