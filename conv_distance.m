function support_nodes=conv_distance(central_node,sub_nodes,pn,node_num)
%%
% the conventional ��distance criterion����ֱ�Ӽ���������Ľڵ�����Ľڵ�
% ��ͳ���ڽ�ѡ��ڵ�ò�Ʋ���Ҫ�ֲ���Ļ��֣�
% Դ������֧�����ڸ��ڵ���Ϣ
% ѡ���ڵ���ΪԴ��󣬱������нڵ㣬�����Դ���������ڵ�ľ��룬����һ��Ԫ������
% �ڵ�: �����ʽ--[��ţ�x���꣬y���꣬�������࣬�߽�����������ʸ��(��x����Ϊ������]
% ���룺
%   central_node: Դ�㣬��������(x,y)
%      sub_nodes: �����ڵ���Ϣ 
%              N: ����ʽ���� node_num���ܽڵ����
%             pn: ѡȡ���������pn���ڵ�
%       node_num: �ڵ�����
% ע�⣺sub_nodes��Ϊ��ڵ��Ű�˳��������ĩλ��ȫ�ֽڵ���
% �����
%   support_nodes:����֧�ŵ� ���ݾ���ѡȡ pn+1 ���ڵ� ������Դ������
%   support_nodes:�����ڵ�����Դ�����
% Ϊ��ʡ�ռ䣬support_nodes�˴��������ڵ��ŵ�һά����
%%
% Ԥ������Ϣ���ӳ����ڲ����ɱ��������븳ֵ
support_nodes=zeros(2,pn);
node=central_node;
nodes_a=sub_nodes;
total=node_num;
%r=radius;
node_d=zeros(total,2);%����Դ������֧�����֧�ŵ��ż�����
% ѭ��������ڵ����(δ�������ڽڵ�����������)
for i=1:total
    node_d(i,1)=sqrt((nodes_a(i,2)-node(1,2))^2+(nodes_a(i,3)-node(1,3))^2);
    node_d(i,2)=i;
end
% B = sortrows(A) ���鰴������
node_d=sortrows(node_d);
% ѡ�������С��ǰ pn ���ڵ�
for i=1:pn
    support_nodes(1,i)=node_d(i,2);% �ڵ���
    support_nodes(2,i)=node_d(i,1);% �ڵ����
end
%δ�����
end
    
