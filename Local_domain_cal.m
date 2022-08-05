function [local_num,local_dis,sub_dis_mat,local_dis_Lrbf,local_inv_rbf,local_shape1]=Local_domain_cal(N,sub_dot_cell,epsilon,floatt)
%%%%%%%%%%%%%%%%%%%%
%����������ڼ���ÿ���ֲ��򣬶�ÿ���ֲ���ʩ����Ӧ�Ŀ��Ʒ���
%���룺
%   N���ֲ�������
%   sub_dot_cell���ֲܾ��򼯺�
%   epsilon����״����
%   floatt:�ض�λ��
%�����
%   local_num��ÿ���ֲ���Ľڵ���
%   local_dis��ÿ���������ĵ�ľ���
%   sub_dis_mat:������󣬾ֲ�����ÿ������������ľ���
%   local_dis_Lrbf:����ÿ����ķ���ƫ΢�ַ��̵ľ������������
%   local_inv_rbf��ÿ���ֲ���������(����ϵ����ʱ����Ҫʹ�ã�
%   local_shape1��ÿһ�е�ϵ����ϵ����װ�նȾ����ã�
%%%%%%%%%%%%%%%%%%%%%
global rbf dyrbf Lrbf L2rbf dyyrbf dxxrbf;
rbf_definition;
local_num=cell(1,N);
local_dis=cell(1,N);
sub_dis_mat=cell(1,N);
local_dis_Lrbf=cell(1,N);
local_dis_rbf=cell(1,N);
local_shape1=cell(1,N);
sub_rbf=cell(1,N);
local_inv_rbf=cell(1,N);
for i=1:N
    t=sub_dot_cell{i};
    local_num{i}=t(:,1);
    x=t(:,2);
    y=t(:,3);
    sub_node=[x,y];
    dis=DistanceMatrix(sub_node,sub_node);
    local_dis{i}=dis(1,:);
    sub_dis_mat{i}=dis;
    if t(1,5)==0     % �ڲ�ƫ΢�ַ���
        sub_rbf{i}=rbf(epsilon,dis);
        local_dis_Lrbf{i}=Lrbf(epsilon,dis);
        local_dis_rbf{i}=Lrbf(epsilon,local_dis{i});
    elseif t(1,5)==1    % �������׺��߽�
        sub_rbf{i}=rbf(epsilon,dis);
        local_dis_Lrbf{i}=Lrbf(epsilon,dis);
        local_dis_rbf{i}=rbf(epsilon,local_dis{i});
    elseif t(1,5)==2  % һ�׵����߽�
        %sub_rbf{i}=dyrbf(epsilon,dis,t(:,3));
        sub_rbf{i}=rbf(epsilon,dis);
        local_dis_Lrbf{i}=Lrbf(epsilon,dis);
        local_dis_rbf{i}=rbf(epsilon,local_dis{i});
    elseif t(1,5)==3  % �ߵ�λ�߽�
        sub_rbf{i}=rbf(epsilon,dis);
        local_dis_Lrbf{i}=Lrbf(epsilon,dis);
        local_dis_rbf{i}=rbf(epsilon,local_dis{i});
    else
        error('����δ����ı߽�������')
    end
    sub_rbf{i}=roundn(sub_rbf{i},floatt);
    local_inv_rbf{i}=roundn(inv(sub_rbf{i}),floatt);
    local_shape1{i}=roundn(local_dis_rbf{i}*local_inv_rbf{i},floatt);
end
end