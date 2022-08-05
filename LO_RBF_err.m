function [U,just_rmse,epsilon_c]=LO_RBF_err(N,epsilon,sub_dot_cell,floatt)
%%%%%%%%%%%%%%%%%%%%
%这个函数用于求解偏微分方程，并且计算出误差估计及其形状参数
%输入：
%   N：节点数量
%   epsilon：形状系数
%   sub_dot_cell：总局部域集合
%   floatt:截断位数
%输出：
%   U：数值解
%   just_rmse：估计误差
%   epsilon_c：形状参数
%%%%%%%%%%%%%%%%%%%%%
%%  计算每个局部域，对每个局部与施加相应的控制方程
[local_num,local_dis,sub_dis_mat,local_dis_Lrbf,local_inv_rbf,local_shape1]=Local_domain_cal(N,sub_dot_cell,epsilon,floatt);
%% 组装各节点形函数,构成总体刚度矩阵
Shape_func=Overall_matrix_assembly(N,local_num,local_shape1);
%% 选定节点赋值（生成右侧）
[u,Lrbf_u]=Calculated_value(N,sub_dot_cell,floatt);
%% 计算结果
U=roundn(Shape_func\u,floatt);
%% 估计误差计算
just_rmse=Solution_est_err(N,sub_dot_cell,U,Lrbf_u,local_inv_rbf,local_dis_Lrbf,local_dis);
%% 形状参数的值
epsilon_c=1./epsilon;
end