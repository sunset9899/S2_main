function Par_Wm_Par_m=Par_Wm_Par_m_initial(Coord_Wm,m_length)
[m,n]=size(Coord_Wm);
Par_Wm_Par_m=zeros(m,n);

for i=1:1:m
    Par_Wm_Par_m(i,:)=cube_1(m_length(i,:),Coord_Wm(i,:),m_length(i,:));
end


end