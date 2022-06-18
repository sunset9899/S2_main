% 前缘线的样条 原样本与插值样本的导数
clear 
clc 
load x
load y 
L_T=xlsread('D:/S2_master/data/L_T.xlsx');
Lx=L_T(:,1);
Ly=L_T(:,2);
scatter(x,y,'r')
hold on
scatter(Lx,Ly,'k')
%% 
pp1=spline(x,y);
xq1=linspace(x(1),x(end),100);
yq1=ppval(pp1,xq1);
dydx1=fnval(fnder(pp1, 1), xq1);
%% 
pp2=spline(Lx,Ly);
xq2=linspace(Lx(1),Lx(end),100);
yq2=ppval(pp2,xq2);
dydx2=fnval(fnder(pp2, 1), xq2);
%% 
figure(1)
plot(xq1,yq1,'-',xq2,yq2,'-.','linewidth',1.5)
figure(2)
plot(xq1,dydx1,'-',xq2,dydx2,'-.')

