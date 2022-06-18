function Tplct_m=loss_initial(Coord_R,Coord_rcu,Coord_Wm,m_length,parameter)
[m,n]=size(Coord_R);
num_m=16;
ii=num_m/2+1;
Zr1=4;
Strang=46.3;
num_qtran=3;
R1=Coord_R(ii,4);
Cu1=Coord_rcu(ii,4)/R1;
Ca1=Coord_Wm(ii,4);
U1=parameter.omega*R1;
W1=sqrt(Ca1^2+(U1-Cu1)^2);
beta1ra=atan((Cu1-U1)/Ca1);

R2=Coord_R(ii,end);
Cu2=Coord_rcu(ii,end)/R1;
Ca2=Coord_Wm(ii,end);
U2=parameter.omega*R2;
W2=sqrt(Ca2^2+(U2-Cu2)^2);
beta2ra=atan((Cu2-U2)/Ca1);
% 
pitch=2*pi*R1/Zr1;
chord=(m_length(ii,15)-m_length(ii,4))/cos(Strang/180*pi);
solidity = chord / pitch;
Deq=(1.12+0.61*cos(beta1ra).^2/solidity*(tan(abs(beta1ra))-tan(abs(beta2ra))))*W1/W2;
if Deq <= 2.1
    WMT1=0.0148*Deq^2-0.0303*Deq+0.02;
else
    WMT1=0.372*Deq^2-1.6042*Deq+1.7561;
end
BLSF1=1.08;
TPLCpro1=2*WMT1*solidity/(cos(beta2ra).^3)*cos(beta1ra).^2*((2*BLSF1)/(3*BLSF1-1)/(1-WMT1*solidity*BLSF1/cos(beta2ra).^3));
C1_m=Coord_Wm(:,4);
R1_m=Coord_R(:,4);
for i=1:1:m
height(i)=(R1_m(i)-R1_m(1))/(R1_m(end)-R1_m(1));
end
T_loss=1;
H_loss=4;
TPLC_3D4_m=zeros(1,m);
for i=1:1:m
    if height(i)>=0.5
        TPLC_3D4_m(i)=TPLCpro1*T_loss*(2*height(i)-1).^3;
    else
        TPLC_3D4_m(i)=TPLCpro1*H_loss*(1-2*height(i)).^3;
    end
end
Tplct_m=zeros(1,m);
for i=1:1:m
    Tplct_m(i)=TPLCpro1*1+TPLC_3D4_m(i)*1;
end
end