% load database
% Date:     2018/08/22
% Auther:   WJK
% Function: This script load the database of data_version.
%           �ýű����뵱ǰ�汾�����ݿ⡣
% Note:     
%    data_version   specify the current database version.
%                   ָ�����ݿ�汾��
% Contact:  jiankunwang@tju.edu.cn

if ~ischar(data_version)
    data_version=n2s(data_version);
end
load(['data/fingerprints' data_version '.mat']);
if exist(['data/testdatas' data_version '.mat'],'file')
    load(['data/testdatas' data_version '.mat']);
else
    disp('No testdata found');
end
