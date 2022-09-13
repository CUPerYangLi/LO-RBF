function [dot2,dot2_array,DB_num,N,points]=Defineasy(nodein,nodeon)
%% Defin
% 功能: 定义节点信息，形如：[编号,x坐标,y坐标,介质种类,边界条件,法向矢量(以x正向为正方向,指向介质外)]
% 函数: dot1=Defin(dot,god)
% 输入:
%   nodein   - 内部点
%   nodeon   - 边界点
% 输出:
%   dot2  - 形式为 dot1:[编号,x坐标,y坐标,介质种类,边界条件,法向矢量(以x正向为正方向)]
%   DB_num - 记录DB节点所在的编号 1*n
%   N节点数量
%   points总点坐标；
%%
num_in=size(nodein,1);
num_on=size(nodeon,1);
N=num_in+num_on;
dot2=cell(1,N);
dot2_array=zeros(N,6);
DB_num=[];
points=zeros(N,2);
for i=1:1:num_in
    number=i;
    dot2_array(i,1)=number;
    dot2_array(i,2)=nodein(i,1);
    dot2_array(i,3)=nodein(i,2);
    points(i,1)=nodein(i,1);
    points(i,2)=nodein(i,2);
end
for i=1:1:num_on
    number=num_in+i;
    dot2_array(num_in+i,1)=number;
    dot2_array(num_in+i,2)=nodeon(i,1);
    dot2_array(num_in+i,3)=nodeon(i,2);
    dot2_array(num_in+i,5)=1;
    points(num_in+i,1)=nodeon(i,1);
    points(num_in+i,2)=nodeon(i,2);
end


end
