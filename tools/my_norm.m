function norm_data=my_norm(data,d_max,d_min)
d=d_max-d_min;
norm_data=(data-d_min)./d;
norm_data(norm_data>1)=1;
norm_data(norm_data<0)=0;