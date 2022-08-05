function support_nodes=conv_distance(central_node,sub_nodes,pn,node_num)
%%
% the conventional “distance criterion”，直接计算距离中心节点最近的节点
% 传统最邻近选择节点貌似不需要局部域的划分？
% 源点所在支持域内各节点信息
% 选定节点作为源点后，遍历所有节点，计算该源点与其他节点的距离，生成一个元胞数组
% 节点: 数组格式--[编号，x坐标，y坐标，介质种类，边界条件，法向矢量(以x正向为正方向）]
% 输入：
%   central_node: 源点，包含坐标(x,y)
%      sub_nodes: 其他节点信息 
%              N: 多项式阶数 node_num：总节点个数
%             pn: 选取距离最近的pn个节点
%       node_num: 节点总数
% 注意：sub_nodes认为其节点编号按顺序来，最末位即全局节点数
% 输出：
%   support_nodes:子域支撑点 根据距离选取 pn+1 个节点 还包含源点在内
%   support_nodes:包括节点编号与源点距离
% 为节省空间，support_nodes此处仅包含节点编号的一维数组
%%
% 预定义信息，子程序内部生成变量对输入赋值
support_nodes=zeros(2,pn);
node=central_node;
nodes_a=sub_nodes;
total=node_num;
%r=radius;
node_d=zeros(total,2);%储存源点所在支持域的支撑点编号及距离
% 循环计算各节点距离(未考虑域内节点数不足的情况)
for i=1:total
    node_d(i,1)=sqrt((nodes_a(i,2)-node(1,2))^2+(nodes_a(i,3)-node(1,3))^2);
    node_d(i,2)=i;
end
% B = sortrows(A) 数组按列排序
node_d=sortrows(node_d);
% 选择距离最小的前 pn 个节点
for i=1:pn
    support_nodes(1,i)=node_d(i,2);% 节点编号
    support_nodes(2,i)=node_d(i,1);% 节点距离
end
%未完待续
end
    
