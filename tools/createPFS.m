function PFS = createPFS(pfs,building,area,type,fps,area_i)
PFS.id=pfs;
PFS.b_id=building;
PFS.a_no=area;
PFS.type=type;
PFS.relativeCoordinates=fps{area_i}.cdns;
switch type
    case 'rssi'
        PFS.data=cell2mat(fps{area_i}.rssis);
    case 'mag'
        PFS.data=fps{area_i}.magnetics;
end
