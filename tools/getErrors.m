function [ Errors ] = getErrors(XData,YData,Pers)
%GETERRORS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Errors=zeros(size(Pers));
for i=1:length(Pers)
    Errors(i)=getError(XData,YData,Pers(i));
end
end

