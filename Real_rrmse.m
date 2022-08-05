function [exact,rmse]=Real_rrmse(N,points,U)
%%%%%%%%%%%%%%%%%%%%
%这个函数用于计算标准解以及相应的均方根误差
%输入：
%   N：离散点数量
%   points：离散点坐标
%   floatt:截断位数
%输出：
%   exact：标准解
%   rmse：均方根误差
%%%%%%%%%%%%%%%%%%%%%
global test
    test_function;
exact=zeros(N,1);
for i=1:N
    x=points(i,1);y=points(i,2);
    exact(i,1)=test(x,y);
end
dU=exact-U;
d_e=sum(dU.^2);
rmse=sqrt(d_e./N);
end