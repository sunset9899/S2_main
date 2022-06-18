function [drdz,dzdr]=drdzdzdr(Coord_R,Coord_Z)
% 输出drdz和dzdr
[m,n]=size(Coord_R);
dzdr=zeros(m,n);
drdz=zeros(m,n);
% 首先求drdz 
for i=1:1:m
    pp=polyfit(Coord_Z(i,:),Coord_R(i,:),3);    % 三阶
    drdz(i,:)=df(pp,Coord_Z(i,:));
end
for j=1:1:n
    pp=polyfit(Coord_R(:,j),Coord_Z(:,j),3);
    dzdr(:,j)=df(pp,Coord_R(:,j));
end

end
