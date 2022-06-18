clear 
clc
L_T=readmatrix('L_T.xlsx' );
m_rCu=readmatrix('m_rcu.xlsx' );
load hs
%%
RZ_parameter.R_num=16;
RZ_parameter.Z_num=18;
RZ_parameter.divide_number1=3;
RZ_parameter.divide_number2=11;
RZ_parameter.divide_number3=3;  %分别给出三部分的均分数 
RZ_parameter.divide_hang=15;    % 行均分数
RZ_parameter.part1=RZ_parameter.divide_number1+1;
RZ_parameter.part2=RZ_parameter.divide_number1+RZ_parameter.divide_number2+1;
RZ_parameter.part3=RZ_parameter.divide_number1+RZ_parameter.divide_number2+RZ_parameter.divide_number3+1;
[Coord_R,Coord_Z]=RZ_initial(hs,L_T,RZ_parameter);
[drdz,dzdr]=drdz_initial(Coord_R,Coord_Z);
% m_length=m_length_initial(Coord_R,Coord_Z);
% q_length=q_length_initial(Coord_R,Coord_Z);
% rcu=rcu_initial(m_length,m_rCu,RZ_parameter);

%% 


% [m,n]=size(Coord_R);
% for i=1:1:m
%     for j=RZ_parameter.part1:1:RZ_parameter.part2
%         rCu(i,j)=0;
%     end
% end
    
