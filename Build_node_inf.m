function dot=Build_node_inf(N,points)
%%%%%%%%%%%%%%%%%%%%
%��������ù�����ɢ�Ľڵ������Ϣ�⣬����ÿ���ڵ�ı�ż�����Ӧ����
%���룺
%   N���ֲ�������
%   points:��ɢ������
%�����
%   dot������ڵ���Ϣ����⣬������ż�����
%%%%%%%%%%%%%%%%%%%%%
dot_array=zeros(N,6);dot=cell(1,N);
for i=1:N
    dot_array(i,1:3)=[i,points(i,1),points(i,2)];
    dot{i}=dot_array(i,:);
end
end