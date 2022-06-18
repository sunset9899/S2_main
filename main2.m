%% 程序声明

%% 
clear 
clc
close all
%%  定义基本参数
input=importdata('data/input.txt');
parameter.Cp=1004;
parameter.keppa=287;
parameter.God=3/0.98;
parameter.density=1.18732;
parameter.rpm=1050;
parameter.omega=2*parameter.rpm*pi/60;
parameter.T_tot_in=297.3;
parameter.R=287;
parameter.P_in=101325;
parameter.P_out=101325+220;
% 没写完，用到哪个导入哪个，全部记录在parameter结构体里
%% 添加数据集路径和函数路径
addpath('D:\S2_master\data')
addpath('D:\S2_master\utils')
%% 定义RZ坐标参数
RZ_parameter.R_num=16;
RZ_parameter.Z_num=18;
RZ_parameter.divide_number1=3;
RZ_parameter.divide_number2=11;
RZ_parameter.divide_number3=3;  %分别给出三部分的均分数 
RZ_parameter.divide_hang=15;    % 行均分数
RZ_parameter.part1=RZ_parameter.divide_number1+1;
RZ_parameter.part2=RZ_parameter.divide_number1+RZ_parameter.divide_number2+1;
RZ_parameter.part3=RZ_parameter.divide_number1+RZ_parameter.divide_number2+RZ_parameter.divide_number3+1;
%% 读入型线
profile=xlsread('D:\S2_master\data\NACA3.xlsx');  %叶型
H_S_line=xlsread('D:\S2_master\data\H_S.xlsx');   %控制点
Theta_R=xlsread('D:\S2_master\data\TH_R.xlsx');   %前缘theta角
m_rCu=xlsread('D:\S2_master\data\m_rcu.xlsx');    %每条流线rCu百分比分布
L_T=xlsread('D:\S2_master\data\L_T.xlsx');        %前缘尾缘线
load('D:\S2_master\data\hs.mat')                  %控制点mat矩阵
% 读入各个数据集

%% 函数列表
%   cube_1                  求三次样条一阶导数
%   RZ_initial              求RZ坐标
%   drdz_initial            求drdz导数项
%   m_length_initial        求流线长度
%   q_length_initial        求q准正交线长度
%   rcu_initial             求沿流线rCu的分布
%   Wz_initial              求各点Wz速度，实际上为定值
%   Wm_initial              求各点沿流向相对速度
%   phi_initial             求流线与z轴夹角
%   gamma_initial           求q线与r轴夹角
%   epsilon_initial         求压力梯度方程最后一项epsilon
%   theta_initial           求R_theta_Z坐标中的theta坐标

%% test 函数
[Coord_R,Coord_Z]=RZ_initial(hs,L_T,RZ_parameter);
Coord_Wz=Wz_initial(Coord_R,parameter);
[drdz,dzdr]=drdzdzdr(Coord_R,Coord_Z);
% m_length=m_length_initial(Coord_R,Coord_Z);
% q_length=q_length_initial(Coord_R,Coord_Z);
load q_length.mat
load m_length.mat
Coord_rcu=rcu_initial(m_length,m_rCu,RZ_parameter);
Coord_phi=phi_initial(drdz);
Coord_gamma=phi_initial(dzdr);
Coord_Wm=Wm_initial(Coord_Wz,Coord_phi);
Coord_theta=theta_initial(Coord_R,Coord_rcu,Coord_Wm,m_length,parameter,RZ_parameter,Theta_R);
% [Par_theta_r,Par_theta_z]=Par_theta_rz(Coord_R,Coord_Z,Coord_theta); % 已弃用，直接用theta和q线求导即可
Par_Wm_Par_m=Par_Wm_Par_m_initial(Coord_Wm,m_length);
Par_phi_Par_m=Par_phi_Par_m_initial(Coord_phi,m_length);
Par_rcu_Par_m=Par_rcu_Par_m_initial(Coord_rcu,m_length);
cot_epsilon=epsilon_initial(Coord_R,Coord_theta,q_length);
theta_q=cot_epsilon./Coord_R;
%% 流线迭代假设初始压力梯度为0，初始压力为1个大气压
[m,n]=size(Coord_R);
p0=zeros(m,n);
for j=1:1:n
    for i=1:1:m
    p0(i,j)=parameter.P_in+(parameter.P_out-parameter.P_in)/(m_length(i,end)-m_length(i,1))*(m_length(i,j)-m_length(i,1));
    end
end
for i=1:1:m
    for j=1:1:n
        test1(i,j)=Coord_Wm(i,j)*Par_Wm_Par_m(i,j)*sin(Coord_gamma(i,j)+Coord_phi(i,j));
        test2(i,j)=Coord_Wm(i,j).^2*Par_phi_Par_m(i,j)*cos(Coord_gamma(i,j)+Coord_phi(i,j));
        test3(i,j)=Coord_rcu(i,j)/Coord_R(i,j).^2*cos(Coord_gamma(i,j));
        test4(i,j)=Coord_Wm(i,j)/Coord_R(i,j)*Par_rcu_Par_m(i,j)*cot_epsilon(i,j);
        Par_p_Par_q(i,j)=Coord_Wm(i,j)*Par_Wm_Par_m(i,j)*sin(Coord_gamma(i,j)+Coord_phi(i,j))+...
                         Coord_Wm(i,j).^2*Par_phi_Par_m(i,j)*cos(Coord_gamma(i,j)+Coord_phi(i,j))-...
                         Coord_rcu(i,j)/Coord_R(i,j).^2*cos(Coord_gamma(i,j))+...
                         Coord_Wm(i,j)/Coord_R(i,j)*Par_rcu_Par_m(i,j)*cot_epsilon(i,j);
    end
end
ppq=Par_p_Par_q*(-1)*parameter.density;
% 
for j=1:1:n

    for i=1:1:m
        x=q_length(1,j):(q_length(i,j)-q_length(1,j))/100:q_length(i,j);
        temp=spline(q_length(:,j),ppq(:,j),x);
        p(i,j)=trapz(x,temp);
    end
end

Coord_P=p+p0;

%% 给定进口温度和速度，求各流线总焓
Coord_beta=atan((parameter.omega*Coord_R-Coord_rcu./Coord_R)./Coord_Wm);
Coord_W=Coord_Wm./cos(Coord_beta);
W_in=Coord_W(:,1);
H_rot=parameter.Cp*parameter.T_tot_in-parameter.omega.^2*Coord_R(:,1).^2/2;
Coord_T_jing=(parameter.Cp*297.3-Coord_W.*2/2)/parameter.Cp;
%% 根据各流线总焓求各个点上的温度
for i=1:1:m
    for j=1:1:n
        Coord_T(i,j)=(H_rot(i)-0.5*Coord_W(i,j).^2+parameter.omega.^2*Coord_R(i,j).^2)/parameter.Cp;
    end
end
%% 根据模型计算损失系数
Tplct_m=loss_initial(Coord_R,Coord_rcu,Coord_Wm,m_length,parameter);
%% 根据损失系数求熵
Coord_thedyn=THEdyn_initial(Coord_Wm,Coord_R,Coord_Z,Coord_rcu,Tplct_m,parameter);
%% 根据熵求温度 （注意，此处求温度是压力迭代的部分，根据流线焓求温度是求熵的过程）
T0=297.3;
Coord_T_re=Coord_T_jing;
for i=1:1:m
    for j=2:1:n
        test6(i,j)=parameter.R*log(Coord_P(i,j)/Coord_P(i,j-1));
        test5(i,j)=Coord_thedyn(i,j)-Coord_thedyn(i,j-1);
        A(i,j)=(Coord_thedyn(i,j)-Coord_thedyn(i,j-1)+parameter.R*log(Coord_P(i,j)/Coord_P(i,j-1)))/parameter.Cp;
        Coord_T_re(i,j)=Coord_T_re(i,j-1)*exp(A(i,j));
    end
end
%% 根据温度求出新的速度
for i=1:1:m
    for j=1:1:n
        w2(i,j)=2*H_rot(i)-2*parameter.Cp*Coord_T_re(i,j);
        Coord_W(i,j)=sqrt(2*H_rot(i)-2*parameter.Cp*Coord_T_re(i,j)+(parameter.omega*Coord_R(i,j)).^2);
        Coord_W(i,j)=real(Coord_W(i,j));
    end
end
% Coord_Wm=Coord_W.*cos(Coord_beta);
% %% 根据速度求流量 
% kdm=2*pi*Coord_R.*0.98*parameter.density.*Coord_Wm.*sin(Coord_gamma+Coord_phi);
% for j=1:1:n
%     Func=kdm(:,j);
%     flow(i)=int(q_length(:,j),Func);
% end
    
% 
% for i=1:1:m
%     figure(1)
%     plot(Coord_Z(i,:),Coord_R(i,:));
%     hold on
% end
% for j=1:1:n
%     figure(1)
%     plot(Coord_Z(:,j),Coord_R(:,j));
%     hold on
% end
% axis equal 
% %% 
%     for j=1:1:n
%     pp=makima(Coord_R(:,j),Coord_Z(:,j));
%         xq(:,j)=linspace(Coord_R(1,j),Coord_R(end,j),100);
%         yq(:,j)=ppval(pp,xq(:,j));
%         xq1(:,j)=cube_1(Coord_R(:,j),Coord_Z(:,j),xq(:,j));
%     end
%     for j=1:1:n
%         figure(2)
%             plot(yq(:,j),xq(:,j));
%     hold on 
%     end
figure()
sub=p;
for j=1:1:18
    subplot(3,6,j)
    plot(Coord_R(:,j),sub(:,j))
    hold on 
    ezplot('0')
    axis([0 0.4 min(sub,[],'all') max(sub,[],'all')])
end
figure()
for i=1:1:16
        subplot(3,6,i)
    plot(Coord_Z(i,:),sub(i,:))
    hold on 
    ezplot('0')
    axis([1.1 1.7 min(sub,[],'all') max(sub,[],'all')])
end
%% 
plot(H_rot)
