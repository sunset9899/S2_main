function m_atan=phi_initial(drdz)
[m,n]=size(drdz);
m_atan=zeros(m,n);
for i=1:1:m
    for j=1:1:n
        m_atan(i,j)=atan(drdz(i,j));
    end
end
end