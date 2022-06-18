function m_length=m_length_initial(Coord_R,Coord_Z)
 %此函数用于计算各点沿流线的长度
[m,n]=size(Coord_R);
m_length=zeros(m,n);
for i=1:1:m
    pp{i}=spline(Coord_Z(i,:),Coord_R(i,:));
% for j=1:1:n-1
%     
% syms x
% F=pp{i}.coefs(j,1)*(x-pp{i}.breaks(j)).^3+pp{i}.coefs(j,2)*(x-pp{i}.breaks(j)).^2+pp{i}.coefs(j,3)*(x-pp{i}.breaks(j)).^1+pp{i}.coefs(j,4)*(x-pp{i}.breaks(j)).^0;
% dF=diff(F);
% F2=power(power(dF,2)+1,0.5);
% s=eval(int(F2,[Coord_Z(i,j),Coord_Z(i,j+1)]));
% m_length(i,j+1)=m_length(i,j)+s;
% end

for j=1:1:n-1
    h=(Coord_Z(i,j+1)-Coord_Z(i,j))/100;
    x=Coord_Z(i,j):h:Coord_Z(i,j+1);
    y=3*pp{i}.coefs(j,1)*(x-pp{i}.breaks(j)).^2+2*pp{i}.coefs(j,2)*(x-pp{i}.breaks(j))+pp{i}.coefs(j,3);
    dy=sqrt(1+y.^2);
    S=trapz(x,dy);
    Coord_dlength(i,j+1)=S;
end
end
    for j=1:1:n
        m_length(:,j)=sum(Coord_dlength(:,1:j),2);
    end

end