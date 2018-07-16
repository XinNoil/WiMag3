function cdfplots(n,xL,yL)
if nargin>0
    new=n;
else
    new=1;
end
colorqueue=['rbkmckgw'];
if exist('tmp/cdf.mat','file')
    load tmp/cdf.mat cdfdata
    if new
        figure('color','w');
    end
    for i=1:length(cdfdata)
        if nargin >1
            mycdfplot(cdfdata{i},0,xL,yL,colorqueue(i),'-');
        else
            mycdfplot(cdfdata{i},0);
        end
    end
end