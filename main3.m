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
%% 1.初始流场生成，
%  1.1初始RZ坐标
[Coord_R,Coord_Z]=RZ_initial(hs,L_T,RZ_parameter);
%  1.2RZ坐标上相关参数
[m,n ]=size(Coord_R);
Coord_Wz=Wz_initial(Coord_R,parameter);
[drdz,dzdr]=drdzdzdr(Coord_R,Coord_Z);
load q_length.mat
load m_length.mat
Coord_rcu=rcu_initial(m_length,m_rCu,RZ_parameter);
Coord_phi=phi_initial(drdz);
Coord_gamma=phi_initial(dzdr);
% [Par_theta_r,Par_theta_z]=Par_theta_rz(Coord_R,Coord_Z,Coord_theta); % 已弃用，直接用theta和q线求导即可
%  1.3初始压力场 
Coord_P=zeros(m,n);
for i=1:1:m
    for j=1:1:RZ_parameter.part1
    Coord_P(i,j)=parameter.P_in;
    
    end
    for j=RZ_parameter.part1:1:RZ_parameter.part2
    Coord_P(i,j)=parameter.P_in+(parameter.P_out-parameter.P_in)/(m_length(i,RZ_parameter.part2)-m_length(i,RZ_parameter.part1))*(m_length(i,j)-m_length(i,RZ_parameter.part1));
    end
    for j=RZ_parameter.part2:1:RZ_parameter.part3
    Coord_P(i,j)=parameter.P_out;
    end
end
%  1.4初始静温度场
H_rot=parameter.Cp*parameter.T_tot_in-parameter.omega.^2*Coord_R(:,1).^2/2;
% 假定第一次没有熵的变化，初始温度由下式子确定
Coord_thedyn=zeros(m,n);
Coord_T=zeros(m,n);
% 假设进口速度不会变
w=wnew(Coord_R,Coord_phi,Coord_rcu,parameter);
Coord_W=zeros(m,n);
Coord_W(:,1)=w(:,1);
Coord_T(:,1)=(parameter.Cp*297.3-Coord_W(:,1).^2/2)/parameter.Cp;
for i=1:1:m
    for j=2:1:n
        A(i,j)=(Coord_thedyn(i,j)-Coord_thedyn(i,j-1)+parameter.R*log(Coord_P(i,j)/Coord_P(i,j-1)))/parameter.Cp;
        Coord_T(i,j)=Coord_T(i,j-1)*exp(A(i,j));
    end
end
% 1.5初始速度场 
for i=1:1:m
    for j=1:1:n
        test1(i,j)=H_rot(i)-parameter.Cp*Coord_T(i,j)+(parameter.omega*Coord_R(i,j)).^2/2;
        test2(i,j)=test1(i,j)*2;
        test3(i,j)=sqrt(test2(i,j));
        Coord_W(i,j)=test3(i,j);
        Coord_W=real(Coord_W);
    end
end
%% 输出参数
plot_figure(Coord_R,Coord_Z,Coord_P)