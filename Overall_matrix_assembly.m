function Shape_func=Overall_matrix_assembly(N,local_num,local_shape1)
%%%%%%%%%%%%%%%%%%%%
%这个函数用于装配待求解的总体刚度矩阵，按照中心点对应的编号将每个局部域的关系式嵌入总体刚度矩阵
%输入：
%   N：局部域数量
%   local_num：每个局部域中心点的编号
%   local_shape1:每个局部域的关系式
%输出：
%   Shape_func：生成的总体刚度矩阵
%%%%%%%%%%%%%%%%%%%%%
Shape_func=zeros(N,N);
for i=1:N
    indx=local_num{i};
    Shape_func(i,indx)=local_shape1{i};
end
end
