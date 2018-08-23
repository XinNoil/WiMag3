% load database
% Date:     2018/08/22
% Auther:   WJK
% Function: This script load the database of data_version.
%           该脚本载入当前版本的数据库。
% Note:     
%    data_version   specify the current database version.
%                   指定数据库版本。
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
