function rcu=rcu_initial(m_length,m_rCu,RZ_parameter)
[m,n]=size(m_length);
x=0:0.01:1;
for i=2:2:32
rcu_percent(i/2,:)=m_rCu(:,i)';
end
% 由于rcu分布给的是百分比形式，首先给出m流线上各点占总流线长度的百分比
m_percent=size(m,n);
rcu=zeros(m,n);
for i=1:1:m
    for j=RZ_parameter.part1:1:RZ_parameter.part2
        m_percent(i,j)=(m_length(i,j)-m_length(i,RZ_parameter.part1))/((m_length(i,RZ_parameter.part2)-m_length(i,RZ_parameter.part1)));   % 由于rcu分布给的是百分比形式，首先给出m流线上各点占总流线长度的百分比,注意只计算叶片上
    end
    rcu(i,RZ_parameter.part1:RZ_parameter.part2)=spline(x,rcu_percent(i,:),m_percent(i,RZ_parameter.part1:RZ_parameter.part2));
end
% 再将rcu分布沿叶片前缘和尾缘延伸
for i=1:1:m
        rcu(i,1:RZ_parameter.part1)=rcu(i,RZ_parameter.part1);
        rcu(i,RZ_parameter.part2:RZ_parameter.part3)=rcu(i,RZ_parameter.part2);
end



end