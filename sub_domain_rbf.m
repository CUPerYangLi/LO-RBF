function [sub_dot_cell,n_nodes]=sub_domain_rbf(nodes,radius,near_nodes)
%% sub_domain
% ����: �˺������ں������������ֲ��������Ƚ��������ɢ����ڵ���ͳ�ƴ���ͳ��DB�ڵ������
% ����: �ú����������Ĭ��Ϊ�����ʽ������Ԫ�������ʽ
% �ڵ�: �����ʽ--[��ţ�x���꣬y���꣬�������࣬�߽�����������ʸ��(��x����Ϊ������]
% ��������: ������ 1 2 3 �ȱ�ʾ
% �߽�����: 0�����ڲ��ṹ,1������߽磬2����һ�׵����߽糣���3�����ڲ��ߵ�λ�߽磬4����һ�׵����߽絼����
% ����: sub_dot=sub_domain(node,nodes)
% ����:
%   nodes  -  ȫ���ڵ���Ϣ
%   radius -  ֧����뾶
% ���:
%   sub_dot_cell: ��Ԫ������ĸ�ʽ���д洢
%   n_nodes:  �����������������������
%% ѡȡ���������pn���㣨������ż����룩
a=size(nodes,1); % ����ڵ�����
b=size(nodes,2);
pn=near_nodes;           % pnѡ�����������pn���㣬ѡ���迼�ǽڵ�ֲ�����������Ǳ߽������������������
for i=1:a
    node=[];
    node=nodes(i,:);
    sp=conv_distance(node,nodes,pn,a); %Ѱ�㺯��
    cell1{i}=sp;
end
%% �ֲ�����ʷ���(�Ƿ�Ϊ��ͬ���ʣ��Ƿ��������
% support_nodes=conv_distance(central_node,sub_nodes,pn,node_num)
% sp:2*pn ��һ�У��ڵ��� �ڶ��У��ڵ����
% conv_distance����ֻ�ǵ���ȷ����������Ľڵ㣬����Ա߽�ڵ���ڽڵ���з���
% conv_distance��δ�漰��֧����İ뾶
% ��sp�еĽڵ�����ڵ�ͱ߽��Ļ���
% �Ƚ��н��ʵĻ��� �޳������ĵ���ʲ�ͬ�ĵ�
%dis=0;nodes_d=zeros(1,pn);
for j=1:a
    spc=cell1{j};
    q=0;p=[];
    for i=1:pn  
        if nodes(j,4)==nodes(spc(1,i),4)
            q=q+1;            %  q: ����ͳ����ͬ���ʽڵ�ĸ���
            p(1,q)=spc(1,i);    %  p: �洢��ͬ���ʵĽڵ���
            p(2,q)=spc(2,i);  %  p: �洢��Ӧ�ڵ�ľ���
        end
    end
    q2=0;p2=[];
    for i=1:q
        if p(2,i)<=radius
            q2=q2+1;
            p2(1,q2)=p(1,i);
            p2(2,q2)=p(2,i);
        end
    end
    nucell2{j}=p2;  % �洢ÿ���ڵ�֧�����ڵĽڵ��ź;���
end
%% ����DB�ڵ㣬�������ӱ�����������n_nodes
% n_cell=[];dbn=0;n_nodes=[];%
% for i=1:a
%     n_nodes(i,:)=nodes(i,:);
%     if nodes(i,5)==2
%         dbn=dbn+1;
%         n_cell(dbn,1)=i;%ɸѡdb�㣬n_cell��ԭ��ţ��±�ţ�
%         n_cell(dbn,2)=dbn+a;
%         n_nodes(dbn+a,:)=nodes(i,:);
%         n_nodes(dbn+a,5)=4;
%         n_nodes(dbn+a,1)=dbn+a;
%     end
% end
n_nodes=nodes;
%% Ѱ�Ҿֲ��ڵ��ڵ�db��
for i=1:a
    
    cell2=[];
    cell2(1,:)=nodes(i,:);
    p3=[];
    p3=nucell2{i};
    a1=size(p3,2);
    num1=0;
    for j=2:a1
        kr=p3(1,j);
        cell2(j,:)=nodes(kr,:);
%         for k=1:dbn
%             if p3(1,j)==n_cell(k,1)
%                 num1=num1+1;
%                 num2=n_cell(k,2);
%                 cell2(a1+num1,:)=n_nodes(num2,:);
%             end
%         end
    end
    sub_dot_cell{i}=cell2;
end
end

    



