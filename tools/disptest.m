function disptest(a)
if ~exist('a','var')||isempty(a)
    disp('default');
else
    disp('test');
end