function distances=pair_euclidean_distance(data)
n=size(data,1);
distances=zeros(n,n);
for i=1:n
    for j=1:n
        distances(i,j)=distance(data(i,:),data(j,:));
    end
end
