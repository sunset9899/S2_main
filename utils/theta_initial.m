function theta=theta_initial(Coord_R,Coord_rcu,Coord_Wm,m_length,parameter,RZ_parameter,Theta_R)
[m,n]=size(Coord_R);
theta=zeros(m,n);
% 如果只积分叶片区域，需要给出叶片区域m流线长度
theta_LE=spline(Theta_R(:,2),Theta_R(:,1)/180*pi,Coord_R(:,1));
m_le=m_length(:,4); %以叶片前缘为积分初始点
for j=1:1:n
m_length(:,j)=m_length(:,j)-m_le;
end
Func=(Coord_rcu-parameter.omega*Coord_R.^2)./(Coord_R.^2.*Coord_Wm);
for i=1:1:m
    for j=1:1:RZ_parameter.part1-1
        x=m_length(i,RZ_parameter.part1):(m_length(i,j)-m_length(i,RZ_parameter.part1))/100:m_length(i,j);
        temp=spline(m_length(i,RZ_parameter.part1:-1:j),Func(i,RZ_parameter.part1:-1:j),x);
        theta(i,j)=trapz(x,temp);
    end
    for j=RZ_parameter.part1+1:1:RZ_parameter.part2
        x=m_length(i,RZ_parameter.part1):(m_length(i,j)-m_length(i,RZ_parameter.part1))/100:m_length(i,j);
        temp=spline(m_length(i,RZ_parameter.part1:1:j),Func(i,RZ_parameter.part1:1:j),x);
        theta(i,j)=trapz(x,temp);
    end
    for j=RZ_parameter.part2+1:1:RZ_parameter.part3
        x=m_length(i,RZ_parameter.part2):(m_length(i,j)-m_length(i,RZ_parameter.part2))/100:m_length(i,j);
        temp=spline(m_length(i,RZ_parameter.part2:1:j),Func(i,RZ_parameter.part2:1:j),x);
        theta(i,j)=trapz(x,temp);
    end
end
for j=1:1:n
    theta(:,j)=theta(:,j)+theta_LE;
end

end