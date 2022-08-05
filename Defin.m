function [dot2,dot2_array,DB_num]=Defin(dot,god)
%% Defin
% 功能: 定义节点信息，形如：[编号,x坐标,y坐标,介质种类,边界条件,法向矢量(以x正向为正方向,指向介质外)]
% 函数: dot1=Defin(dot,god)
% 输入:
%   god   - 求解域几何信息
%   dot   - 形式为 dot:[编号,x坐标,y坐标,介质种类,边界条件,法向矢量(以x正向为正方向)] 1*n
% 输出:
%   dot2  - 形式为 dot1:[编号,x坐标,y坐标,介质种类,边界条件,法向矢量(以x正向为正方向)]
%   DB_num - 记录DB节点所在的编号 1*n
%%
x1=god{1,1};y1=god{1,2};%构造求解区域；
x2=god{2,1};%电板；

%以下对各点所属介质分类
dot1=dot;
% Point函数生成的离散点cell个数
t=size(dot);t=t(2);
%dot1_array=zeros(t,6);
t1=0;%重新计点，用于刨除不良点
s_db=0;%统计DB节点数
for i=1:t
    d=dot{i};
    %区分介质
    %区分边界，0代表内部结构,1代低电位边界，2代表一阶导数边界，3代表内部高电位边界
    if d(3)==y1(1)
        if (d(2)>x2(1)) && (d(2)<x2(2)) % 电极位置，高电位边界 介质设为1
            %t1=t1+1;
            d(4)=1;
            d(5)=3;
            d(6)=270;
        else                    % 电极所在边界其余部分 该边界进行零通量处理 一阶导数边界条件
            d(4)=1;
            d(5)=2;
            
        end
    elseif (d(3)>y1(1)) && (d(3)<y1(2))
        if (d(2)==x1(1))||(d(2)==x1(2)) % 其余边界，一阶导数边界条件
            d(4)=1;
            d(5)=2;
        else
            d(4)=1;
            d(5)=0;% 内部点
        end
    else% 其余边界，低点电位
        if (d(2)>x2(1)) && (d(2)<x2(2))
            d(4)=1;
            d(5)=1;
            d(6)=90;
        else
            d(4)=1;
            d(5)=2;
        end
    end
    if d(5)==2
        s_db=s_db+1;
    end
    dot1{i}=d;
    %dot1_array(i,:)=d;
end
% 不剔除高电位的节点 对DB节点编号进行统计
dot2=cell(1,t-t1);% t1=0
dot2_array=zeros(t-t1,6);
k=0;kd=0;
DB_num=zeros(1,s_db);
for i=1:t
    d=dot1{i};
    dot2{1,i}=d;
    dot2_array(i,:)=d;
    if d(5)==2
        kd=kd+1;
        DB_num(1,kd)=d(1);
        if d(2)==0
            dot2_array(i,6)=180;
        end
    end
end
% for i=1:t
%     d=dot1{i};
%     if d(3)==x1(1) && (d(2)>=x2(1)) && (d(2)<=x2(2))
%         %k=k;
%     else
%         k=k+1;
%         d(1)=k;
%         dot2{1,k}=d;
%         dot2_array(k,:)=d;
%         if d(5)==2
%             kd=kd+1;
%             DB_num(1,kd)=d(1);
%         end
%     end
% end

end
