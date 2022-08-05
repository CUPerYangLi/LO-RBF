function Estimation_rmse=Solution_est_err(N,sub_dot_cell,U,Lrbf_u,local_inv_rbf,local_dis_Lrbf,local_dis)
%%%%%%%%%%%%%%%%%%%%
%这个函数用于计算估计误差，
%输入：
%   N：局部域数量
%   sub_dot_cell：总局部域集合
%   U：点的计算结果
%   Lrbf_u：偏微分方程所在位置的值
%   local_inv_rbf：局部域的逆
%   local_dis_Lrbf：局部域形成的多项式符合偏微分方程的值
%   local_dis：中心点与局部域内其它点的距离
%输出：
%   Estimation_rmse：估计误差
%%%%%%%%%%%%%%%%%%%%%
Select_basis=1;%判断误差估计方式
Select_weight=0;%判断是否添加正则化项
Estimation_rmse2=0;
Local_err={N};
all_local=[];%存储每个局部域误差的平方
all_nodes_num=0;
%     for i=1:N
%         max_up1=max(local_dis{i});
%         max_up=min(max_up,max_up1);
%     end
switch Select_basis
    %% 二范数
    case 1
        for i=1:N
            max_up=max(local_dis{i});
            t=sub_dot_cell{i};
            Nt=size(t,1);
            local_U=zeros(Nt,1);
            local_Lrbf_u=zeros(Nt,1);
            for j=1:Nt
                num_t=t(j,1);
                local_U(j,1)=U(num_t);
                
                local_Lrbf_u(j,1)=Lrbf_u(num_t);
            end
            weight_size=size(local_dis{i},2);
            all_nodes_num=all_nodes_num+weight_size;%记录总点数
            if Select_weight==1
                local_diss=(1+cos(pi./2*(local_dis{i}./(max_up))+pi./2)).^2;%正则化项
                local_weight=diag(local_diss');%对角化
            else
                local_weight=eye(weight_size);%对角化%无正则化项
            end
            local_a=local_inv_rbf{i}*local_U;%计算局部域的径向基系数
            Local_err{i}=abs(local_dis_Lrbf{i}*local_a-local_Lrbf_u);%计算局部域每个点的残差
            Estimation_rmse2=Estimation_rmse2+Local_err{i}'*local_weight*Local_err{i};%累加
        end
        Estimation_rmse=sqrt(Estimation_rmse2./all_nodes_num);
        %% 无穷范数
    case 2
        for i=1:N
            max_up=max(local_dis{i});
            t=sub_dot_cell{i};
            Nt=size(t,1);
            local_U=zeros(Nt,1);
            local_Lrbf_u=zeros(Nt,1);
            for j=1:Nt
                num_t=t(j,1);
                local_U(j,1)=U(num_t);
                
                local_Lrbf_u(j,1)=Lrbf_u(num_t);
            end
            weight_size=size(local_dis{i},2);
            all_nodes_num=all_nodes_num+weight_size;%记录总点数
            if Select_weight==1
                local_diss=(1+cos(pi./2*(local_dis{i}./(max_up))+pi./2)).^2;%正则化项
                local_weight=diag(local_diss');%对角化
            else
                local_weight=eye(weight_size);%对角化%无正则化项
            end
            local_a=local_inv_rbf{i}*local_U;
            Local_err{i}=abs(local_dis_Lrbf{i}*local_a-local_Lrbf_u);
            all_local(i)=Local_err{i}'*local_weight*Local_err{i};
        end
        local_rmse2=max(sqrt(all_local));%无正则化项
        Estimation_rmse=local_rmse2;
    otherwise
        error('can not find Select_basis')
end
