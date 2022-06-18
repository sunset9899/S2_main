R_num=16;
Z_num=18;
divide_number1=3;
divide_number2=11;
divide_number3=3; %分别给出三部分的均分数 
part1=4;
part2=15;
part3=18;
Coord_Z=zeros(R_num,Z_num);
Coord_R=zeros(R_num,Z_num);
% 输入已知点值
Coord_Z(:,1)=1.1;
Coord_Z(:,end)=1.7;
Z_Shroud_1_length=(H_S_line(2,4)-H_S_line(1,4))/divide_number1; % hub线上z坐标
Z_Hub_1_length=(H_S_line(2,3)-H_S_line(1,3))/divide_number1;    % hub线上z坐标
for i=1:1:part1
Coord_Z(1,i)=Coord_Z(1,1)+Z_Shroud_1_length*(i-1);
Coord_Z(end,i)=Coord_Z(end,1)+Z_Hub_1_length*(i-1);
end
Z_Shroud_2_length=(H_S_line(3,4)-H_S_line(2,4))/divide_number2; % hub线上z坐标
Z_Hub_2_length=(H_S_line(3,3)-H_S_line(2,3))/divide_number2;    % hub线上z坐标
for i=part1:1:part2
Coord_Z(1,i)=Coord_Z(1,4)+Z_Shroud_2_length*(i-4);
Coord_Z(end,i)=Coord_Z(end,4)+Z_Hub_2_length*(i-4);
end
Z_Shroud_3_length=(H_S_line(4,4)-H_S_line(3,4))/divide_number3; % hub线上z坐标
Z_Hub_3_length=(H_S_line(4,3)-H_S_line(3,3))/divide_number3;    % hub线上z坐标
for i=part2:1:part3
Coord_Z(1,i)=Coord_Z(1,15)+Z_Shroud_3_length*(i-15);
Coord_Z(end,i)=Coord_Z(end,15)+Z_Hub_3_length*(i-15);
end
%% 生成R坐标
R_Hub=0.0904;
R_Shroud=0.306;
R_m=zeros(16,1);
R_m(1)=0.0904;
for i=2:1:R_num
    R_m(i)=sqrt((R_Shroud^2-R_Hub^2)/divide_hang+R_m(i-1)^2);
end
for i=1:1:Z_num
    Coord_R(:,i)=R_m;
end
%% 插值前缘线和尾缘线
R_L_line=R_m;%前缘线的R坐标
R=L_T(:,1);
Z=L_T(:,2);
Z_L_line=spline(R,Z,R_line)