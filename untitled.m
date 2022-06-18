%% 程序声明

%% 
clear 
clc 
load Coord_R 
load Coord_Z
x=Coord_R(:,15);
y=Coord_Z(:,15);
dx=0.0904:0.001:0.306;
dy=spline(x,y,dx)
plot(x,y,'o',dx,dy);