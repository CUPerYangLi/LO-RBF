function [exact,rmse]=Real_rrmse(N,points,U)
%%%%%%%%%%%%%%%%%%%%
%����������ڼ����׼���Լ���Ӧ�ľ��������
%���룺
%   N����ɢ������
%   points����ɢ������
%   floatt:�ض�λ��
%�����
%   exact����׼��
%   rmse�����������
%%%%%%%%%%%%%%%%%%%%%
global test
    test_function;
exact=zeros(N,1);
for i=1:N
    x=points(i,1);y=points(i,2);
    exact(i,1)=test(x,y);
end
dU=exact-U;
d_e=sum(dU.^2);
rmse=sqrt(d_e./N);
end