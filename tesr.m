clear 
clc 
load x
load y 
L_T=xlsread('D:/S2_master/data/L_T.xlsx');
Lx=L_T(:,1);
Ly=L_T(:,2);
%% 方法1 三次样条
pp1=spline(x,y);
xq1=linspace(x(1),x(16),100);
yq1=ppval(pp1,xq1);
dydx1=fnval(fnder(pp1, 1), xq1);
%% 方法2 hermit样条
pp2=pchip(x,y);
xq2=linspace(x(1),x(16),100);
yq2=ppval(pp2,xq2);
dydx2=fnval(fnder(pp2, 1), xq2);
%% 方法3 修正样条
pp3=makima(x,y);
xq3=linspace(x(1),x(16),100);
yq3=ppval(pp3,xq3);
dydx3=fnval(fnder(pp3, 1), xq3);
%% 方法4 拉格朗日函数法
xq4=linspace(x(1),x(16),100);
yq4=lagrange(x,y,xq4);
% 拉格朗日误差极大，确定不可行
%% 方法5 最小二乘近似 
xq5=linspace(x(1),x(16),100);
pp5=polyfit(x,y,3);
syms x5
f=pp5(1)*x5.^3+pp5(2)*x5.^2+pp5(3)*x5.^1+pp5(4);
df=diff(f);
f=matlabFunction(f);
df=matlabFunction(df);
for i=1:1:100
    yq51(i)=f(xq5(i));
    dydx5(i)=df(xq5(i));
end
yq5=polyval(pp5,xq5);
%% 对比拟合函数
figure()
plot(x,y,'o',xq1,yq1,'-',xq2,yq2,'-.',xq3,yq3,'--',xq5,yq5,':','linewidth',1.5)
legend('spline','pchip','makima','poly')
axis equal
%% 对比一阶导数
figure()
plot(xq1,dydx1,'-',xq2,dydx2,'-.',xq3,dydx3,'--',xq5,dydx5,':','linewidth',1.5)
legend('spline','pchip','makima','poly')

%% function 
function y=lagrange(x0,y0,x)
% 给定一系列点x0,y0 
% x是我们要预测的值，由于可以有多个，因此用向量表示
% y返回我们的估计值，由于可以有多个，因此用向量表示
    n = length(x);% 要预测的个数
    y = zeros(n);% 初始化，并赋初值0
    for k = 1:length(x0)
        j_no_k=find((1:length(x0))~=k);% 在这里，find函数用于返回一个向量中不为下标k的元素（下标从1开始）
        y1=1;
        for j = 1:length(j_no_k)
            y1 = y1.*(x-x0(j_no_k(j))); % ∏(x-xj)
        end
        y = y + y1*y0(k)/prod(x0(k)-x0(j_no_k));% prod函数返回数组元素的乘积
    end
end
