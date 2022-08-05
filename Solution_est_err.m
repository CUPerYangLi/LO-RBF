function Estimation_rmse=Solution_est_err(N,sub_dot_cell,U,Lrbf_u,local_inv_rbf,local_dis_Lrbf,local_dis)
%%%%%%%%%%%%%%%%%%%%
%����������ڼ��������
%���룺
%   N���ֲ�������
%   sub_dot_cell���ֲܾ��򼯺�
%   U����ļ�����
%   Lrbf_u��ƫ΢�ַ�������λ�õ�ֵ
%   local_inv_rbf���ֲ������
%   local_dis_Lrbf���ֲ����γɵĶ���ʽ����ƫ΢�ַ��̵�ֵ
%   local_dis�����ĵ���ֲ�����������ľ���
%�����
%   Estimation_rmse���������
%%%%%%%%%%%%%%%%%%%%%
Select_basis=1;%�ж������Ʒ�ʽ
Select_weight=0;%�ж��Ƿ����������
Estimation_rmse2=0;
Local_err={N};
all_local=[];%�洢ÿ���ֲ�������ƽ��
all_nodes_num=0;
%     for i=1:N
%         max_up1=max(local_dis{i});
%         max_up=min(max_up,max_up1);
%     end
switch Select_basis
    %% ������
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
            all_nodes_num=all_nodes_num+weight_size;%��¼�ܵ���
            if Select_weight==1
                local_diss=(1+cos(pi./2*(local_dis{i}./(max_up))+pi./2)).^2;%������
                local_weight=diag(local_diss');%�Խǻ�
            else
                local_weight=eye(weight_size);%�Խǻ�%��������
            end
            local_a=local_inv_rbf{i}*local_U;%����ֲ���ľ����ϵ��
            Local_err{i}=abs(local_dis_Lrbf{i}*local_a-local_Lrbf_u);%����ֲ���ÿ����Ĳв�
            Estimation_rmse2=Estimation_rmse2+Local_err{i}'*local_weight*Local_err{i};%�ۼ�
        end
        Estimation_rmse=sqrt(Estimation_rmse2./all_nodes_num);
        %% �����
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
            all_nodes_num=all_nodes_num+weight_size;%��¼�ܵ���
            if Select_weight==1
                local_diss=(1+cos(pi./2*(local_dis{i}./(max_up))+pi./2)).^2;%������
                local_weight=diag(local_diss');%�Խǻ�
            else
                local_weight=eye(weight_size);%�Խǻ�%��������
            end
            local_a=local_inv_rbf{i}*local_U;
            Local_err{i}=abs(local_dis_Lrbf{i}*local_a-local_Lrbf_u);
            all_local(i)=Local_err{i}'*local_weight*Local_err{i};
        end
        local_rmse2=max(sqrt(all_local));%��������
        Estimation_rmse=local_rmse2;
    otherwise
        error('can not find Select_basis')
end
