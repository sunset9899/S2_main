function [drdz,dzdr]=drdz_initial(Coord_R,Coord_Z)
% Êä³ödrdzºÍdzdr
[m,n]=size(Coord_R);
dzdr=zeros(m,n);
drdz=zeros(m,n);
for j=1:1:n
    dzdr(:,j)=cube_1(Coord_R(:,j),Coord_Z(:,j),Coord_R(:,j));
end
for i=1:1:m
    drdz(i,:)=cube_1(Coord_Z(i,:),Coord_R(i,:),Coord_Z(i,:));
end
end
