function Par_phi_Par_m=Par_phi_Par_m_initial(Coord_phi,m_length)
[m,n]=size(Coord_phi);
Par_phi_Par_m=zeros(m,n);

for i=1:1:m
    Par_phi_Par_m(i,:)=cube_1(m_length(i,:),Coord_phi(i,:),m_length(i,:));
end


end