function [ Pers ] = getPers(XData,YData,Errors)
%GETERRORS 此处显示有关此函数的摘要
%   此处显示详细说明
Pers=zeros(size(Errors));
for i=1:length(Errors)
    Pers(i)=getPer(XData,YData,Errors(i));
end
end
