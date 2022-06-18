clear;
clc
delta=1.05;
m=1600;
yita=0.85;
g=9.8;
f=0.013;
Cd=0.3;
A=2;
syms P v real 
F1 = int(1/(3.6)*delta*m/(3600*P*yita/v-(m*g*f+Cd*A*v^2/21.15)),v,0,50);
F2 = int(1/(3.6)*delta*m/(3600*P*yita/v-(m*g*f+Cd*A*v^2/21.15)),v,50,80);
F3 = int(1/(3.6)*delta*m/(3600*P*yita/v-(m*g*f+Cd*A*v^2/21.15)),v,0,100);
F1 =matlabFunction(F1);
F2 =matlabFunction(F2);
F3 =matlabFunction(F3);
P=70:0.1:130;
for i=1:1:length(P)
    F1_store(i)=F1(P(i));
    F2_store(i)=F2(P(i));
    F3_store(i)=F3(P(i));
end

%% 作图
plot(P,F1_store,'r--')
hold on 
plot(P,F2_store,'b--')
hold on
plot(P,F3_store,'k-')
title('标题')
xlabel('驱动功率/kW')
ylabel('加速时间/s')
legend('0-100km/h','0-50km/h','50-80km/h')
axis([70 140 0 13])
% plot(P,F(P),'k-')