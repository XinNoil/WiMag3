function my_predict_error(data,mag_err,strs)
nbin=10;
edges=linspace(min(data),max(data), nbin+1);
c=(edges(2:end)+edges(1:end-1))/2;
s_err=zeros(1,nbin);
s_n=zeros(1,nbin);
for r=1:length(data)
    i=get_mybin1(data(r),edges);
    s_err(i)=s_err(i)+mag_err(r);
    s_n(i)=s_n(i)+1;
end
a_err=s_err./s_n;
b=~isnan(a_err);
c=c(b);
a_err=a_err(b);
fittedmodel=fit(c',a_err','poly1')
figure( 'Name', 'fittedmodel' );
h = plot( fittedmodel, c, a_err );
set(h,'Linewidth',2,'MarkerSize',10);
legend( h, [strs{1} ' vs. ' strs{2}], 'fittedmodel', 'Location', 'SouthEast');
figFormat(25,strs{1},strs{2});