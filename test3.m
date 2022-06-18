% 尾缘线的样条 原样本与插值样本的导数
clear 
clc 
load weiyuanx
load weiyuany
x=weiyuanx;
y=weiyuany;
L_T=xlsread('D:/S2_master/data/L_T.xlsx');
Lx=L_T(:,3);
Ly=L_T(:,4);
figure(1)
scatter(x,y,'r')
hold on
scatter(Lx,Ly,'k')
%% 
pp1=spline(x,y);
xq1=linspace(x(1),x(end),100);
yq1=ppval(pp1,xq1);
dydx1=atan(fnval(fnder(pp1, 1), xq1))/pi*180;
%% 
pp2=makima(x,y);
xq2=linspace(x(1),x(end),100);
yq2=ppval(pp2,xq2);
dydx2=atan(fnval(fnder(pp2, 1), xq2))/pi*180;
%% 
figure(2)
plot(xq1,yq1,'-',xq2,yq2,'-.','linewidth',1.5)
axis equal
figure(3)
plot(xq1,dydx1,'-',xq2,dydx2,'-.')
%% 
for i=2:2:32
    subplot(3,6,i/2)
    plot(mrcu(:,i))
end

