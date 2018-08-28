function parameters=load_parameters()
load tmp/wimag.mat
if exist('parameters','var')
    parameters.exist=true;
else
    parameters.exist=false;
end