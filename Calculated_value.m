function [u,Lrbf_u]=Calculated_value(N,sub_dot_cell,floatt)
%%%%%%%%%%%%%%%%%%%%
%����������ڼ��������Ӧ�㷽�̵�ֵ�Լ�����ƫ΢�ַ��̵�ֵ�������Է����Ҳ���ֵu�Լ�˫������Ԥװ��ϵ��Lrbf_u��
%���룺
%   N���ֲ�������
%   sub_dot_cell���ֲܾ��򼯺�
%   floatt:�ض�λ��
%�����
%   u����Ӧ��ķ���ֵ
%   Lrbf_u����Ӧ�����ƫ΢�ַ��̵�ֵ
%%%%%%%%%%%%%%%%%%%%%
global test  dfdxx1  dfdxx2 dfdx1 dfdx2
test_function;
u=zeros(N,1);
Lrbf_u=zeros(N,1);
for i=1:N
    t=sub_dot_cell{i};
    xx=t(1,2);yy=t(1,3);
    if t(1,5)==0     % �ڲ�ƫ΢�ַ��̼�����
        %sub_rbf{i}=Lrbf(epsilon,dis);
        %u(i)=test(xx,yy);
        u(i)=dfdxx1(xx,yy)+dfdxx2(xx,yy);
        Lrbf_u(i)=dfdxx1(xx,yy)+dfdxx2(xx,yy);
    elseif t(1,5)==1    % �������׺��߽���
        %sub_rbf{i}=rbf(epsilon,dis);
        %u(i)=test(xx,yy);
        u(i)=test(xx,yy);
        Lrbf_u(i)=dfdxx1(xx,yy)+dfdxx2(xx,yy);
    elseif t(1,5)==2  % �������׺��߽���
        %sub_rbf{i}=dyrbf(epsilon,dis,t(:,3));
        %u(i)=test(xx,yy);
        u(i)=test(xx,yy);
        Lrbf_u(i)=dfdxx1(xx,yy)+dfdxx2(xx,yy);
    elseif t(1,5)==3  % �������׺��߽���
        %sub_rbf{i}=rbf(epsilon,dis);
        %u(i)=10;
        %u(i)=test(xx,yy);
        u(i)=test(xx,yy);
        Lrbf_u(i)=dfdxx1(xx,yy)+dfdxx2(xx,yy);
    else
        error('����δ����ı߽�������');
    end
    u(i)=roundn(u(i),floatt);
end
end