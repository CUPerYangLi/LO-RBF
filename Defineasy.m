function [dot2,dot2_array,DB_num,N,points]=Defineasy(nodein,nodeon)
%% Defin
% ����: ����ڵ���Ϣ�����磺[���,x����,y����,��������,�߽�����,����ʸ��(��x����Ϊ������,ָ�������)]
% ����: dot1=Defin(dot,god)
% ����:
%   nodein   - �ڲ���
%   nodeon   - �߽��
% ���:
%   dot2  - ��ʽΪ dot1:[���,x����,y����,��������,�߽�����,����ʸ��(��x����Ϊ������)]
%   DB_num - ��¼DB�ڵ����ڵı�� 1*n
%   N�ڵ�����
%   points�ܵ����ꣻ
%%
num_in=size(nodein,1);
num_on=size(nodeon,1);
N=num_in+num_on;
dot2=cell(1,N);
dot2_array=zeros(N,6);
DB_num=[];
points=zeros(N,2);
for i=1:1:num_in
    number=i;
    dot2_array(i,1)=number;
    dot2_array(i,2)=nodein(i,1);
    dot2_array(i,3)=nodein(i,2);
    points(i,1)=nodein(i,1);
    points(i,2)=nodein(i,2);
end
for i=1:1:num_on
    number=num_in+i;
    dot2_array(num_in+i,1)=number;
    dot2_array(num_in+i,2)=nodeon(i,1);
    dot2_array(num_in+i,3)=nodeon(i,2);
    dot2_array(num_in+i,5)=1;
    points(num_in+i,1)=nodeon(i,1);
    points(num_in+i,2)=nodeon(i,2);
end


end
