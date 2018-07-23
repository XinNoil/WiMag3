function plot_blocks(num,block_size,st_columns,st_margin,st_rows,s)
for i=1:num
    columns(i).index=s+[0:block_size:block_size*st_columns(i)];
    s=columns(i).index(end)+st.gap(i);
end
for i=1:num
    for j=0:st_rows
        plot(offset.x+[columns(i).index(1) columns(i).index(end)],offset.y+st_margin+[j*block_size j*block_size],'k-');
    end
    for j=0:st.columns(i)
        plot(offset.x+columns(i).index(1)+[j*block_size j*block_size],offset.y+st_margin+[0 st.rows*block_size],'k-');
    end
end