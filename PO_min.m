function [U,just_rmse,epsilon_c]=PO_min(N0,sub_dot_cell,floatt,local_rmse)
%粒子群算法实现搜索函数最小值
%% 初始化参数
N = 10;                         % 初始种群个数
d = 1;                          % 空间维数
ger = 20;                      % 最大迭代次数
limit = [0, 1];                % 设置位置参数限制
vlimit = [-0.1, 0.1];               % 设置速度限制
w = 0.6;                        % 惯性权重
c1 = 0.5;                       % 自我学习因子
c2 = 0.5;                       % 群体学习因子
for i = 1:d
    x = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, d);%初始种群的位置
end
v = rand(N, d);                  % 初始种群的速度
xm = x;                          % 每个个体的历史最佳位置
ym = zeros(1, d);                % 种群的历史最佳位置
fxm = zeros(N, 1);               % 每个个体的历史最佳适应度
fym = 0;                      % 种群历史最佳适应度
%% 群体更新
iter = 1;
record = zeros(ger, 1);          % 记录器
x0=local_rmse(:,1);
y0=local_rmse(:,2);
while iter <= ger
    for i=1:N
        [U0,just_rmse0,epsilon_c0]=LO_RBF_err(N0,1./x(i),sub_dot_cell,floatt);% 个体当前适应度
        fx(i)=1./just_rmse0;
    end
    for i = 1:N
        if fxm(i) < fx(i)
            fxm(i) = fx(i);     % 更新个体历史最佳适应度
            
            xm(i,:) = x(i,:);   % 更新个体历史最佳位置
        end
    end
    if fym < max(fxm)
        [fym, nmax] = max(fxm);   % 更新群体历史最佳适应度
        ym = xm(nmax, :);      % 更新群体历史最佳位置
        best_x(iter)=1./fx(nmax);
    end
    v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% 速度更新
    % 边界速度处理
    for i=1:N
        if v(i) > vlimit(2)
            v(i)= vlimit(2);
        elseif v(i) < vlimit(1)
            v(i)= vlimit(1);
        end
    end
    x = x + v;% 位置更新
    % 边界位置处理
    for i=1:N
        if x(i)>limit(2)
            x(i)=limit(2);
        elseif x(i)<limit(1)
            x(i)=limit(1);
        end
    end
    record(iter) = fym;%最大值记录
    for i=1:N
        [U0,just_rmse0,epsilon_c0]=LO_RBF_err(N0,1./x(i),sub_dot_cell,floatt);% 个体当前适应度
        fx(i)=1./just_rmse0;
    end
    %semilogy(x0, y0, 'b-',x, 1./fx, 'ro');title('收敛图'),
    createfigure2D_PO(x0,y0,x,1./fx,iter),
     pause(0.1)
    iter = iter+1;
end
figure2 = figure;
plot(best_x);
xlabel('迭代次数');
[U,just_rmse,epsilon_c]=LO_RBF_err(N0,1./ym,sub_dot_cell,floatt);
end


