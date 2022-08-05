function [u,Lrbf_u]=Calculated_value(N,sub_dot_cell,floatt)
%%%%%%%%%%%%%%%%%%%%
%这个函数用于计算符合相应点方程的值以及符合偏微分方程的值，（线性方程右侧数值u以及双生矩阵预装配系数Lrbf_u）
%输入：
%   N：局部域数量
%   sub_dot_cell：总局部域集合
%   floatt:截断位数
%输出：
%   u：相应点的方程值
%   Lrbf_u：相应点符合偏微分方程的值
%%%%%%%%%%%%%%%%%%%%%
global test  dfdxx1  dfdxx2 dfdx1 dfdx2
test_function;
u=zeros(N,1);
Lrbf_u=zeros(N,1);
for i=1:N
    t=sub_dot_cell{i};
    xx=t(1,2);yy=t(1,3);
    if t(1,5)==0     % 内部偏微分方程计算结果
        %sub_rbf{i}=Lrbf(epsilon,dis);
        %u(i)=test(xx,yy);
        u(i)=dfdxx1(xx,yy)+dfdxx2(xx,yy);
        Lrbf_u(i)=dfdxx1(xx,yy)+dfdxx2(xx,yy);
    elseif t(1,5)==1    % 狄利克雷函边界结果
        %sub_rbf{i}=rbf(epsilon,dis);
        %u(i)=test(xx,yy);
        u(i)=test(xx,yy);
        Lrbf_u(i)=dfdxx1(xx,yy)+dfdxx2(xx,yy);
    elseif t(1,5)==2  % 狄利克雷函边界结果
        %sub_rbf{i}=dyrbf(epsilon,dis,t(:,3));
        %u(i)=test(xx,yy);
        u(i)=test(xx,yy);
        Lrbf_u(i)=dfdxx1(xx,yy)+dfdxx2(xx,yy);
    elseif t(1,5)==3  % 狄利克雷函边界结果
        %sub_rbf{i}=rbf(epsilon,dis);
        %u(i)=10;
        %u(i)=test(xx,yy);
        u(i)=test(xx,yy);
        Lrbf_u(i)=dfdxx1(xx,yy)+dfdxx2(xx,yy);
    else
        error('出现未定义的边界条件！');
    end
    u(i)=roundn(u(i),floatt);
end
end