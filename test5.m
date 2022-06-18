[m,n]=size(Coord_R);
theta=zeros(m,n);
[m,n]=size(Coord_rcu);
Par_rcu_Par_m=zeros(m,n);
i=16;
dx=(m_length(i,15)-m_length(i,4))/100;
xq=m_length(i,4):dx:m_length(i,15);
pp=makima(m_length(i,4:15),Coord_rcu(i,4:15));
yq=makima(m_length(i,4:15),Coord_rcu(i,4:15),xq);
dydx = fnval(fnder(pp, 1), xq); %求在xq上的一阶导
plot(m_length(i,4:15),Coord_rcu(i,4:15),'o',xq,yq)
