function [Coord_R,Coord_Z]=RZ_initial(hs,L_T,RZ_parameter)
part1=RZ_parameter.divide_number1+1;
part2=RZ_parameter.divide_number1+RZ_parameter.divide_number2+1;
part3=RZ_parameter.divide_number1+RZ_parameter.divide_number2+RZ_parameter.divide_number3+1;
Coord_Z=zeros(RZ_parameter.R_num,RZ_parameter.Z_num);
Coord_R=zeros(RZ_parameter.R_num,RZ_parameter.Z_num);
%% 输入已知点值
Coord_R(1,1)=hs(1,1);
Coord_R(1,part1)=hs(2,1);
Coord_R(1,part2)=hs(3,1);
Coord_R(1,part3)=hs(4,1);
Coord_R(end,1)=hs(5,1);
Coord_R(end,part1)=hs(6,1);
Coord_R(end,part2)=hs(7,1);
Coord_R(end,part3)=hs(8,1);
Coord_Z(1,1)=hs(1,2);
Coord_Z(1,part1)=hs(2,2);
Coord_Z(1,part2)=hs(3,2);
Coord_Z(1,part3)=hs(4,2);
Coord_Z(end,1)=hs(5,2);
Coord_Z(end,part1)=hs(6,2);
Coord_Z(end,part2)=hs(7,2);
Coord_Z(end,part3)=hs(8,2);
%% Z坐标等距离划分
for i=1:1:16
    k1=(Coord_Z(i,part1)-Coord_Z(i,1))/RZ_parameter.divide_number1;
    k2=(Coord_Z(i,part2)-Coord_Z(i,part1))/RZ_parameter.divide_number2;
    k3=(Coord_Z(i,part3)-Coord_Z(i,part2))/RZ_parameter.divide_number3;
    for j=1:1:part1
    Coord_Z(i,j)=Coord_Z(i,1)+k1*(j-1);
    end
    for j=part1:1:part2
    Coord_Z(i,j)=Coord_Z(i,part1)+k2*(j-part1);
    end
    for j=part2:1:part3
    Coord_Z(i,j)=Coord_Z(i,part2)+k3*(j-part2);
    end
end
%% R坐标等面积划分 
R_Hub=Coord_R(1,1);
R_Shroud=Coord_R(end,1);
R_m=Coord_R(:,1);
for i=2:1:RZ_parameter.R_num
    R_m(i)=sqrt((R_Shroud^2-R_Hub^2)/RZ_parameter.divide_hang+R_m(i-1)^2);
end
for i=1:1:RZ_parameter.Z_num
    Coord_R(:,i)=R_m;
end
%% 插值前缘尾缘线
R_L_line=R_m;%前缘线的R坐标
R_T_line=R_m;
R=L_T(:,1);
Z=L_T(:,2);
Z_L_line=spline(R,Z,R_L_line);
R=L_T(:,3);
Z=L_T(:,4);
Z_T_line=spline(R,Z,R_T_line);
Coord_Z(:,1)=1.1;
Coord_Z(:,part1)=Z_L_line;
Coord_Z(:,part2)=Z_T_line;
Coord_Z(:,part3)=1.7;
%% 根据前缘尾缘线确定剩余的Z坐标
for i=1:1:16
    k1=(Coord_Z(i,part1)-Coord_Z(i,1))/RZ_parameter.divide_number1;
    k2=(Coord_Z(i,part2)-Coord_Z(i,part1))/RZ_parameter.divide_number2;
    k3=(Coord_Z(i,part3)-Coord_Z(i,part2))/RZ_parameter.divide_number3;
    for j=1:1:part1
    Coord_Z(i,j)=Coord_Z(i,1)+k1*(j-1);
    end
    for j=part1:1:part2
    Coord_Z(i,j)=Coord_Z(i,part1)+k2*(j-part1);
    end
    for j=part2:1:part3
    Coord_Z(i,j)=Coord_Z(i,part2)+k3*(j-part2);
    end
end
end


