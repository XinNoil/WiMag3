function show_matrix_image(c,n,t)
if n==0
    figure('color','white');
end
c=c-min(c(:));
c=c.*64./max(c(:));
c=c';
c=flipud(c);

image(c)
colormap(jet)
colorbar
axis off
title(t)
set(gca,'FontSize',20,'FontName','times new roman','FontWeight','bold');