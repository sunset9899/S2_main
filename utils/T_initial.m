function T=T_initial(T0,Sj_S1,Coord_p,parameter)
% 根据各点压力及熵增求温度
[m,n]=size(Coord_p);
T=zeros(m,n);
T(1,:)=T0;
A=zeros(m,n);
for j=1:1:n
    for i=2:1:m
        A(i,j)=(Sj_S1(i,j)-Sj_S1(i-1)+parameter.R*log(p(i,j)/p(i-1,j)))/parameter.cp;
        T(i,j)=T(i-1,j)*exp(A(i,j));
    end
end

end