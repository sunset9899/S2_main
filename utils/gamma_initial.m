function gamma=gamma_initial(dzdr)
[m,n]=size(dzdr);
gamma=zeros(m,n);
for i=1:1:m
    for j=1:1:n
        gamma(i,j)=atan(drdz(i,j));
    end
end
end