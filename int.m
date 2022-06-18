function [inty] = int(x,Func)
%INT 此处显示有关此函数的摘要 
% x为积分域 Func为被积函数
% 
dx=(x(end)-x(1))/100;
xq=x(1):dx:x(end); % 细分积分域 
yq=spline(x,Func,xq);% 得到细分积分域上的函数值
inty=trapz(xq,yq);
end

