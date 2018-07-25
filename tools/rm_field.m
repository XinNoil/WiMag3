function s=rm_field(s,field)
if isfield(s,field)
    s=rmfield(s,field);
end