function no = get_No( pos,cdns )
%GET_NO �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
a=find(cdns(:,1)==pos(1));
b=find(cdns(:,2)==pos(2));
no=intersect(a,b);
if(length(no)>1)
    disp('Error');
    exit;
end
end

