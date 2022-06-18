function Wm=Wm_initial(Wz,phi)
[m,n]=size(Wz);
Wm=zeros(m,n);
for i=1:1:m
    for j=1:1:n
        Wm(i,j)=Wz(i,j)/cos(phi(i,j));
    end
end
end