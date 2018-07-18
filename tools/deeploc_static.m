function deeploc_static(filename,type,sub_area_num)
switch type
    case 1
        data=csvread(filename,1,1);
        nums=data(:,3);
        errors=data(:,2);
        mean_error=sum(errors.*nums)/sum(nums);
        disp(mean_error)
    case 2
        data=load(filename);
        nums=data(:,2);
        errors=data(:,3);
        mean_error=sum(errors.*nums)/sum(nums);
        disp(mean_error)
end
figure;
bar(errors)
figFormat(20,'Area No','Error distance (m)')
xlim([0 sub_area_num+1])
ylim([0 5]);