function nearest_neighbour=find_nearest_neighbour(cdns,cdn)
d_cdn=cdns-cdn;
dis=mnorm(d_cdn,2);
min_dis=min(dis);
nearest_neighbour=find(abs(dis-min_dis)<1e-5);