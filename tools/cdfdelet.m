function cdfdelet(n)
if nargin>1
    load tmp/cdf.mat cdfdata
    cdfdata=cdfdata(1:end-n);
    save tmp/cdf.mat cdfdata
else
    load tmp/cdf.mat cdfdata
    cdfdata=cdfdata(1:end-1);
    save tmp/cdf.mat cdfdata
end