function H_rot=H_rot_initial(T,Coord_W,Coord_R,parameter)
% 求转动总焓

H_rot=parameter.cp.*T+Coord_W.^2/2-(parameter.omega.*Coord_R).^2;


end