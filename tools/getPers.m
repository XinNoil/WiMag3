function [ Pers ] = getPers(XData,YData,Errors)
%GETERRORS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Pers=zeros(size(Errors));
for i=1:length(Errors)
    Pers(i)=getPer(XData,YData,Errors(i));
end
end
