function w_=w_initial(P_tot_2_s,P_tot_2,parameter,Wm)
% 计算总压损失系数

w_=(P_tot_2_s-P_tot_2)/(1/2*parameter.density*Wm);





end