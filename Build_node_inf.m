function dot=Build_node_inf(N,points)
%%%%%%%%%%%%%%%%%%%%
%这个函数用构造离散的节点矩阵信息库，生成每个节点的编号及其相应坐标
%输入：
%   N：局部域数量
%   points:离散点坐标
%输出：
%   dot：矩阵节点信息矩阵库，包含编号及坐标
%%%%%%%%%%%%%%%%%%%%%
dot_array=zeros(N,6);dot=cell(1,N);
for i=1:N
    dot_array(i,1:3)=[i,points(i,1),points(i,2)];
    dot{i}=dot_array(i,:);
end
end