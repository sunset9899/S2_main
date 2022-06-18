function [Par_theta_r,Par_theta_z]=Par_theta_rz(Coord_R,Coord_Z,Coord_theta)
[m,n ]=size(Coord_R);
Par_theta_r=zeros(m,n);
Par_theta_z=zeros(m,n);
for i=1:1:m
        Par_theta_z(i,:)=cube_1(Coord_Z(i,:),Coord_theta(i,:),Coord_Z(i,:));
    
end
for j=1:1:n
        Par_theta_r(:,j)=cube_1(Coord_R(:,j),Coord_theta(:,j),Coord_R(:,j));
    
end

end