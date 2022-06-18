function Sj_S1=Sj_S1_initial(parameter,w,p1,p_tot_1,T_tot_1,T_tot)
[m,n]=size(T_tot);
Sj_S1=zeros(m,n);
% 计算每个点相对于q线初始点的熵增

for j=1:1:n
    for i=1:1:m
    Sj_S1(i,j)=-parameter.keppa*log(1-w*(1-p1/p_tot_1)*(T_tot_1/T_tot(i,j)).^(1.4/(1.4-1)));
    end
end



end