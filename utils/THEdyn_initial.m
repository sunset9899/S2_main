function  thedyn=THEdyn_initial(Coord_Wm,Coord_R,Coord_Z,Coord_rcu,Tplct_m,parameter)
k=1.4;
Rg=287;
[m,n]=size(Coord_R);
Ca1_m=Coord_Wm(:,4);
R1_m=Coord_R(:,4);
U1_m=parameter.omega*R1_m;
CU1_m=Coord_rcu(:,4)./Coord_R(:,4);
W1_m=((U1_m-CU1_m).^2+Ca1_m.^2).^0.5;
% 
Ca2_m=Coord_Wm(:,15);
R2_m=Coord_R(:,15);
U2_m=parameter.omega*R2_m;
CU2_m=Coord_rcu(:,15)./Coord_R(:,15);
W2_m=((U2_m-CU2_m).^2+Ca2_m.^2).^0.5;
% 
Coord_Ca=Coord_Wm;
Coord_Cu=Coord_rcu./Coord_R;
Coord_C=sqrt(Coord_Ca.^2+Coord_Cu.^2);
% 焓
for i=1:1:m
    for j=1:1:n
Coord_T_tot(i,j)=parameter.T_tot_in;
    end
end
Coord_Enthalpy=zeros(m,n);
for i=1:1:m
    for j=1:1:4
        Coord_Enthalpy(i,j)=parameter.Cp*Coord_T_tot(i,j);
    end
    for j=5:1:16
        Coord_Enthalpy(i,j)=Coord_Enthalpy(i,4)-parameter.omega*Coord_rcu(i,4)+parameter.omega*Coord_rcu(i,j);
    end
    for j=17:1:18
        Coord_Enthalpy(i,j)=Coord_Enthalpy(i,15);
    end
end
Coord_T_tot=Coord_Enthalpy./parameter.Cp;
% 求静温和静焓
Coord_Enthalpy_S=Coord_Enthalpy-0.5*Coord_C.^2;
Coord_T_S=Coord_Enthalpy_S./parameter.Cp;
% 计算前缘到尾缘的熵
enthalpy_T1=Coord_Enthalpy(:,4);
enthalpy_T2=Coord_Enthalpy(:,15);
enthalpy_S1=Coord_Enthalpy_S(:,4);
enthalpy_S2=Coord_Enthalpy_S(:,15);
T_tot_1=Coord_T_tot(:,4);
T_tot_2=Coord_T_tot(:,15);
T_S_1=Coord_T_S(:,4);
T_S_2=Coord_T_S(:,15);
TT1w_m=(enthalpy_S1+0.5*W1_m.^2)/parameter.Cp;
TT2w_m=(enthalpy_S2+0.5*W2_m.^2)/parameter.Cp;
soundw1_m=(k*Rg*T_S_1).^0.5;
mach_m=W1_m./soundw1_m;
% 熵函数
Coord_PS=parameter.density*Rg.*Coord_T_S;
temp1=k/(k-1);
temp2=(k-1)/2*mach_m.^2;
temp3=(TT2w_m./TT1w_m).^(temp1);
test1=zeros(1,m);
for i=1:1:m
test1(i)=Tplct_m(i)*(1-(1+0.5.*(k-1).*mach_m(i).^2).^(k/(k-1)));
test2(i)=(TT2w_m(i)./TT1w_m(i)).^(k/(k-1));
enthalpyFun2_m(i)=1+test1(i)/test2(i);
end
% 定义分布规律
for i=1:1:m
    for j=1:1:4
         Coord_enthalpy_Fun(i,j)=1;
    end
    for j=5:1:15
        Coord_enthalpy_Fun(i,j)=(enthalpyFun2_m(i)-1)*(Coord_Z(i,j)-Coord_Z(i,4))/(Coord_Z(i,15)-Coord_Z(i,4))+1;
    end
    for j=16:1:18
        Coord_enthalpy_Fun(i,j)=enthalpyFun2_m(i);
    end
end    
thedyn=-Rg*log(Coord_enthalpy_Fun);
    end