%% ���������в�� �ֲ��������㲴�ɣ�������test_function,�˳������Ҫ��;�Ǽ���ֲ�������ĵ㴦�󵼺�����ϵ
% ������
clc
clear all
floatt=-16;%���徫��
%%  �����������̬
%god=Domain();
%�˴�ֱ�ӵ��� CreatePoints ���������� [0,1]��Χ�ڵĽڵ�
%[nodes, N] = CreatePoints(121,2,'u');
%������ʼ��
N=900;%�ڵ�����
s=2;%�ռ�ά�� �˴�Ϊ��άƽ��
gridtype='u';%���ɽڵ����ͣ�ѡ������
%% ��ɢ�������
[points, N] = CreatePoints(N,s,gridtype);
%% ����ɢ����Ϣ����
dot=Build_node_inf(N,points);
%% Լ����ⷶΧ
god=Domain_rbf();
%% ������Ϣ������ɢ����з���
[dot1,dot1_array,DB_num]=Defin(dot,god);  
%%  ֧����ڵ㻮�ּ���ŵ����¶���
% [sub_dot,sub_dot_cell,type,num_dot]=sub_domain(node,nodes,radius,near_nodes)
% �缫λ�ã��ߵ�λ�߽� ������Ϊ0 ������Ϊ����1
% ���ֱ߽磬0�����ڲ��ṹ,1������߽磬2����һ�׵����߽磬3�����ڲ��ߵ�λ�߽磬4����һ�׵����߽絼����
radius=1;     % Լ��1���ֲ����������Χ
near_nodes=25;   % Լ��2���ֲ����ѡȡ����
tol_node=size(dot1_array,1);
nodes=dot1_array;
szz=100;%��������
% �� conv_distance �������Ѿ���������룬�ɵ��øò���ֵ��Ϊ�������
[sub_dot_cell,n_nodes]=sub_domain_rbf(nodes,radius,near_nodes);
%%  ����ȫ�ֽڵ������󣬵���������״�����뾫�ȵĹ�ϵ
local_rmse=zeros(szz,2);
epsilon_rmse=zeros(szz,2);
for epsilon_num=1:1:szz
    epsilon=100./epsilon_num;%��״������ֵ%��״������ֵ
    %epsilon=szz;%��״������ֵ%��״������ֵ
    [U,just_rmse,epsilon_c]=LO_RBF_err(N,epsilon,sub_dot_cell,floatt);
    %% �������
    local_rmse(epsilon_num,1)=epsilon_c;
    local_rmse(epsilon_num,2)=just_rmse;
    %% ��ʵRRMSE���
    [exact,rmse]=Real_rrmse(N,points,U);
    epsilon_rmse(epsilon_num,2)=rmse;
    %% ��״������ֵ
    epsilon_rmse(epsilon_num,1)=epsilon_c;   
end
%% �����ͼ
Figure_result(exact,U,local_rmse,epsilon_rmse,nodes);