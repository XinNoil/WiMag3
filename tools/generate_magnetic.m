function new_mag=generate_magnetic(tmp_magnetics,gsize)
tmp_mean=mean(tmp_magnetics,1);
tmp_std=std(tmp_magnetics,1);
new_mag_xy=normrnd(tmp_mean(1),tmp_std(1),[gsize,1]);
new_mag_z=normrnd(tmp_mean(2),tmp_std(2),[gsize,1]);
new_mag=[new_mag_xy new_mag_z];