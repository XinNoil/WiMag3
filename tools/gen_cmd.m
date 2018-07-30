function cmd=gen_cmd(paras)
cmd='python3 ';
if isfield(paras,'pro_name')
    cmd = [cmd paras.pro_name ' '];
else
    cmd = [cmd 'cdn_predict.py '];
end
if isfield(paras,'data_ver')
    cmd = [cmd '-v ' paras.data_ver ' '];
end
if isfield(paras,'data_name')
    cmd = [cmd '-n ' paras.data_name ' '];
end
if isfield(paras,'feature_mode')
    cmd = [cmd '-f ' paras.feature_mode ' '];
end
if isfield(paras,'dropout')
    cmd = [cmd '-d ' n2s(paras.dropout) ' '];
end
if isfield(paras,'batch_size')
    cmd = [cmd '-b ' n2s(paras.batch_size) ' '];
end
if isfield(paras,'exp_num')
    cmd = [cmd '-x ' paras.exp_num ' '];
end
if isfield(paras,'epoch')
    cmd = [cmd '-e ' n2s(paras.epoch) ' '];
else
    cmd = [cmd '-e 30'];
end