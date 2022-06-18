clc
load H_rot.mat
H_rot=H_rot+(parameter.omega*Coord_R(:,1)).^2;
p2p1=101545/101325;
A=(0+287*log(p2p1))/1004;
T2T1=exp(A);
T=H_rot/T2T1/1004;
w=sqrt(H_rot/(1/(T2T1-1)/2+1/2));
wm=H_rot/(1/(T2T1-1)/2+1/2)+(Coord_rcu(:,1)./Coord_R(:,1)).^2-(parameter.omega*Coord_R(:,1)).^2;
wm=sqrt(wm);
