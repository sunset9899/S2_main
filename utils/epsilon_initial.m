function cot_epsilon=epsilon_initial(Coord_R,Coord_theta,q_length)
[m,n]=size(Coord_R);
cot_epsilon=zeros(m,n);
for j=1:1:n
    cot_epsilon(:,j)=cube_1(q_length(:,j),Coord_theta(:,j),q_length(:,j));
end

cot_epsilon=Coord_R.*cot_epsilon;
end