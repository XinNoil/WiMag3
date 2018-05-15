function [ Errors ] = getErrors(XData,YData,Pers)
%GETERRORS 此处显示有关此函数的摘要
%   此处显示详细说明
Errors=zeros(size(Pers));
for i=1:length(Pers)
    Errors(i)=getError(XData,YData,Pers(i));
end
end

