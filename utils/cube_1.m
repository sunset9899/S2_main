function yq_1 = cube_1(x,y,xq)
%CUBE_1 �˴���ʾ�йش˺�����ժҪ: ����ԭʼ��x y ���꣬���xq�����ϵ�һ�׵���ֵ
%   �˴���ʾ��ϸ˵��

% pp=makima(x,y);  % pp Ϊ����������ֵ�Ľṹ��
% yq_1 = fnval(fnder(pp, 1), xq); %����xq�ϵ�һ�׵�
pp=polyfit(x,y,3);  % pp Ϊ����������ֵ�Ľṹ��
yq_1 = df(pp,xq); %����xq�ϵ�һ�׵�

end

