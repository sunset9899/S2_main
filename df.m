function [df] = df(pp,x)
%DF 简单的三次函数求导
df=3*pp(1).*x.^2+2*pp(2).*x+pp(3);



end

