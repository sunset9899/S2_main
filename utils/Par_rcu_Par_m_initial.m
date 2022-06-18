function Par_rcu_Par_m=Par_rcu_Par_m_initial(Coord_rcu,m_length)
[m,n]=size(Coord_rcu);
Par_rcu_Par_m=zeros(m,n);

for i=1:1:m
    Par_rcu_Par_m(i,1:3)=cube_1(m_length(i,1:3),Coord_rcu(i,1:3),m_length(i,1:3));
    Par_rcu_Par_m(i,4:15)=cube_1(m_length(i,4:15),Coord_rcu(i,4:15),m_length(i,4:15));
    Par_rcu_Par_m(i,16:18)=cube_1(m_length(i,16:18),Coord_rcu(i,16:18),m_length(i,16:18));
end


end