function [inty] = int(x,Func)
%INT �˴���ʾ�йش˺�����ժҪ 
% xΪ������ FuncΪ��������
% 
dx=(x(end)-x(1))/100;
xq=x(1):dx:x(end); % ϸ�ֻ����� 
yq=spline(x,Func,xq);% �õ�ϸ�ֻ������ϵĺ���ֵ
inty=trapz(xq,yq);
end

