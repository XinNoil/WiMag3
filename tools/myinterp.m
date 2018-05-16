function new_row_index=myinterp(bs,row_index)
new_row_index=row_index;
index_d=row_index(2:end)-row_index(1:end-1);
n=length(index_d);
for i=1:n
    if (abs(index_d(i))>bs/2)
        new_row_index(end+1)=(row_index(i+1)+row_index(i))/2;
    end
end
new_row_index=sort(new_row_index);
