function [local_num,local_dis,sub_dis_mat,local_dis_Lrbf,local_inv_rbf,local_shape1]=Local_domain_cal(N,sub_dot_cell,epsilon,floatt)
%%%%%%%%%%%%%%%%%%%%
%这个函数用于计算每个局部域，对每个局部与施加相应的控制方程
%输入：
%   N：局部域数量
%   sub_dot_cell：总局部域集合
%   epsilon：形状参数
%   floatt:截断位数
%输出：
%   local_num：每个局部域的节点编号
%   local_dis：每个点与中心点的距离
%   sub_dis_mat:距离矩阵，局部域中每个点与其它点的距离
%   local_dis_Lrbf:计算每个点的符合偏微分方程的径向基函数矩阵
%   local_inv_rbf：每个局部域矩阵的逆(计算系数的时候需要使用）
%   local_shape1：每一行的系数关系（组装刚度矩阵用）
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
    if t(1,5)==0     % 内部偏微分方程
        sub_rbf{i}=rbf(epsilon,dis);
        local_dis_Lrbf{i}=Lrbf(epsilon,dis);
        local_dis_rbf{i}=Lrbf(epsilon,local_dis{i});
    elseif t(1,5)==1    % 狄利克雷函边界
        sub_rbf{i}=rbf(epsilon,dis);
        local_dis_Lrbf{i}=Lrbf(epsilon,dis);
        local_dis_rbf{i}=rbf(epsilon,local_dis{i});
    elseif t(1,5)==2  % 一阶导数边界
        %sub_rbf{i}=dyrbf(epsilon,dis,t(:,3));
        sub_rbf{i}=rbf(epsilon,dis);
        local_dis_Lrbf{i}=Lrbf(epsilon,dis);
        local_dis_rbf{i}=rbf(epsilon,local_dis{i});
    elseif t(1,5)==3  % 高电位边界
        sub_rbf{i}=rbf(epsilon,dis);
        local_dis_Lrbf{i}=Lrbf(epsilon,dis);
        local_dis_rbf{i}=rbf(epsilon,local_dis{i});
    else
        error('出现未定义的边界条件！')
    end
    sub_rbf{i}=roundn(sub_rbf{i},floatt);
    local_inv_rbf{i}=roundn(inv(sub_rbf{i}),floatt);
    local_shape1{i}=roundn(local_dis_rbf{i}*local_inv_rbf{i},floatt);
end
end