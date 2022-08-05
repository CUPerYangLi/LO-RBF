%% ——导数残差—— 局部径向基配点泊松，函数见test_function,此程序的主要用途是计算局部域非中心点处求导后误差关系
% 主函数
clc
clear all
floatt=-16;%定义精度
%%  给出物体的形态
%god=Domain();
%此处直接调用 CreatePoints 函数，生成 [0,1]范围内的节点
%[nodes, N] = CreatePoints(121,2,'u');
%参数初始化
N=900;%节点总数
s=2;%空间维度 此处为二维平面
gridtype='u';%生成节点类型，选择规则点
%% 离散求解区域
[points, N] = CreatePoints(N,s,gridtype);
%% 构造散点信息矩阵
dot=Build_node_inf(N,points);
%% 约束求解范围
god=Domain_rbf();
%% 完善信息矩阵离散点进行分类
[dot1,dot1_array,DB_num]=Defin(dot,god);  
%%  支持域节点划分及编号的重新定义
% [sub_dot,sub_dot_cell,type,num_dot]=sub_domain(node,nodes,radius,near_nodes)
% 电极位置，高电位边界 介质设为0 其余设为介质1
% 区分边界，0代表内部结构,1代表外边界，2代表一阶导数边界，3代表内部高电位边界，4代表一阶导数边界导数项
radius=1;     % 约束1：局部域点搜索范围
near_nodes=25;   % 约束2：局部域点选取上限
tol_node=size(dot1_array,1);
nodes=dot1_array;
szz=100;%迭代几次
% 在 conv_distance 函数中已经计算过距离，可调用该部分值作为距离矩阵
[sub_dot_cell,n_nodes]=sub_domain_rbf(nodes,radius,near_nodes);
%%  计算全局节点距离矩阵，迭代计算形状参数与精度的关系
local_rmse=zeros(szz,2);
epsilon_rmse=zeros(szz,2);
for epsilon_num=1:1:szz
    epsilon=100./epsilon_num;%形状参数赋值%形状参数赋值
    %epsilon=szz;%形状参数赋值%形状参数赋值
    [U,just_rmse,epsilon_c]=LO_RBF_err(N,epsilon,sub_dot_cell,floatt);
    %% 估计误差
    local_rmse(epsilon_num,1)=epsilon_c;
    local_rmse(epsilon_num,2)=just_rmse;
    %% 真实RRMSE误差
    [exact,rmse]=Real_rrmse(N,points,U);
    epsilon_rmse(epsilon_num,2)=rmse;
    %% 形状参数的值
    epsilon_rmse(epsilon_num,1)=epsilon_c;   
end
%% 结果绘图
Figure_result(exact,U,local_rmse,epsilon_rmse,nodes);