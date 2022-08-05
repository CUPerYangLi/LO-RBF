function [sub_dot_cell,n_nodes]=sub_domain_rbf(nodes,radius,near_nodes)
%% sub_domain
% 功能: 此函数用于海尔米特型配点局部域处理，首先将输入的离散分类节点做统计处理，统计DB节点个数，
% 声明: 该函数输入输出默认为数组格式，而非元胞数组格式
% 节点: 数组格式--[编号，x坐标，y坐标，介质种类，边界条件，法向矢量(以x正向为正方向）]
% 介质种类: 用数字 1 2 3 等表示
% 边界条件: 0代表内部结构,1代表外边界，2代表一阶导数边界常数项，3代表内部高电位边界，4代表一阶导数边界导数项
% 函数: sub_dot=sub_domain(node,nodes)
% 输入:
%   nodes  -  全部节点信息
%   radius -  支持域半径
% 输出:
%   sub_dot_cell: 以元胞数组的格式进行存储
%   n_nodes:  所有项个数（含常数项、导数项）
%% 选取距离最近的pn个点（储存点编号及距离）
a=size(nodes,1); % 计算节点总数
b=size(nodes,2);
pn=near_nodes;           % pn选定距离最近的pn个点，选择需考虑节点分布情况，尤其是边界点的情况，可酌情增大
for i=1:a
    node=[];
    node=nodes(i,:);
    sp=conv_distance(node,nodes,pn,a); %寻点函数
    cell1{i}=sp;
end
%% 局部点介质分类(是否为相同介质，是否在求解域）
% support_nodes=conv_distance(central_node,sub_nodes,pn,node_num)
% sp:2*pn 第一行：节点编号 第二行：节点距离
% conv_distance函数只是单纯确定距离最近的节点，还需对边界节点和内节点进行分类
% conv_distance并未涉及到支持域的半径
% 对sp中的节点进行内点和边界点的划分
% 先进行介质的划分 剔除跟中心点介质不同的点
%dis=0;nodes_d=zeros(1,pn);
for j=1:a
    spc=cell1{j};
    q=0;p=[];
    for i=1:pn  
        if nodes(j,4)==nodes(spc(1,i),4)
            q=q+1;            %  q: 用来统计相同介质节点的个数
            p(1,q)=spc(1,i);    %  p: 存储相同介质的节点编号
            p(2,q)=spc(2,i);  %  p: 存储相应节点的距离
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
    nucell2{j}=p2;  % 存储每个节点支持域内的节点编号和距离
end
%% 处理DB节点，对其做加倍处理生成新n_nodes
% n_cell=[];dbn=0;n_nodes=[];%
% for i=1:a
%     n_nodes(i,:)=nodes(i,:);
%     if nodes(i,5)==2
%         dbn=dbn+1;
%         n_cell(dbn,1)=i;%筛选db点，n_cell（原编号，新编号）
%         n_cell(dbn,2)=dbn+a;
%         n_nodes(dbn+a,:)=nodes(i,:);
%         n_nodes(dbn+a,5)=4;
%         n_nodes(dbn+a,1)=dbn+a;
%     end
% end
n_nodes=nodes;
%% 寻找局部节点内的db点
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

    



