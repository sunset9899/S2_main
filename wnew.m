function w=wnew(Coord_R,Coord_phi,Coord_rcu,parameter)
Coord_Wz=Wz_initial(Coord_R,parameter);
Coord_Wm=Wm_initial(Coord_Wz,Coord_phi);
Coord_beta=atan((parameter.omega*Coord_R-Coord_rcu./Coord_R)./Coord_Wm);
w=Coord_Wm./cos(Coord_beta);
end



