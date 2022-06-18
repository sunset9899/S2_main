function Wz=Wz_initial(Coord_R,p)
[m,n]=size(Coord_R);
Wz_chuzhi=p.God/p.density/pi/(Coord_R(end,1).^2-Coord_R(1,1).^2);
Wz=zeros(m,n);
Wz(:,:)=Wz_chuzhi;

end