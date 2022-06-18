% 此函数用于显示云图
function plot_figure(Coord_R,Coord_Z,a)
[m,n]=size(Coord_R);
x=reshape(Coord_Z,m*n,1);
y=reshape(Coord_R,m*n,1);
q=reshape(a,m*n,1);
x_1=min(x);
x_r=max(x);
y_1=min(y);
y_r=max(y);
nn=500;
xlabel=linspace(x_1,x_r,nn);
ylabel=linspace(y_1,y_r,nn);
[X_plot,Y_plot]=meshgrid(xlabel,ylabel);
Z_plot=griddata(x,y,q,X_plot,Y_plot,'cubic');
figure()
pcolor(xlabel,ylabel,Z_plot)
shading interp 
colormap jet 
axis equal 
colorbar
end