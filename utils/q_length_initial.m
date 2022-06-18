function q_length=q_length_initial(Coord_R,Coord_Z)
 %此函数用于计算各点沿q准正交线的长度,直接套用了m流线的函数，转置一下即可
 Coord_R=Coord_R';
 Coord_Z=Coord_Z';
[m,n]=size(Coord_R);
q_length=zeros(m,n);
for i=1:1:m
    pp{i}=spline(Coord_R(i,:),Coord_Z(i,:));
% for j=1:1:n-1
% syms x
% F=pp{i}.coefs(j,1)*(x-pp{i}.breaks(j)).^3+pp{i}.coefs(j,2)*(x-pp{i}.breaks(j)).^2+pp{i}.coefs(j,3)*(x-pp{i}.breaks(j)).^1+pp{i}.coefs(j,4)*(x-pp{i}.breaks(j)).^0;
% dF=diff(F);
% F2=power(power(dF,2)+1,0.5);
% s=eval(int(F2,[Coord_R(i,j),Coord_R(i,j+1)]));
% m_length(i,j+1)=m_length(i,j)+s;
% end
for j=1:1:n-1
    h=(Coord_R(i,j+1)-Coord_R(i,j))/100;
    x=Coord_R(i,j):h:Coord_R(i,j+1);
    y=3*pp{i}.coefs(j,1)*(x-pp{i}.breaks(j)).^2+2*pp{i}.coefs(j,2)*(x-pp{i}.breaks(j))+pp{i}.coefs(j,3);
    dy=sqrt(1+y.^2);
    S=trapz(x,dy);
    Coord_dlength(i,j+1)=S;
end

end
    for j=1:1:n
        q_length(:,j)=sum(Coord_dlength(:,1:j),2);
    end
    
    
end