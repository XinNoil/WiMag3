function cdfappend(data)
if exist('tmp/cdf.mat','file')
    load tmp/cdf.mat cdfdata
    cdfdata{end+1}=data;
else
    cdfdata{1}=data;
end
save tmp/cdf.mat cdfdata