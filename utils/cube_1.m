function yq_1 = cube_1(x,y,xq)
%CUBE_1 此处显示有关此函数的摘要: 输入原始的x y 坐标，输出xq坐标上的一阶导数值
%   此处显示详细说明

% pp=makima(x,y);  % pp 为三次样条插值的结构体
% yq_1 = fnval(fnder(pp, 1), xq); %求在xq上的一阶导
pp=polyfit(x,y,3);  % pp 为三次样条插值的结构体
yq_1 = df(pp,xq); %求在xq上的一阶导

end

