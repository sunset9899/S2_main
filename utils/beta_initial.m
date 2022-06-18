function beta=beta_initial(Coord_rcu,Coord_Wm,Coord_R,parameter)
beta=atan((parameter.omega*Coord_R.^2-Coord_rcu)./(Coord_R.*Coord_Wm));

end