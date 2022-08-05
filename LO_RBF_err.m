function [U,just_rmse,epsilon_c]=LO_RBF_err(N,epsilon,sub_dot_cell,floatt)
%%%%%%%%%%%%%%%%%%%%
%��������������ƫ΢�ַ��̣����Ҽ���������Ƽ�����״����
%���룺
%   N���ڵ�����
%   epsilon����״ϵ��
%   sub_dot_cell���ֲܾ��򼯺�
%   floatt:�ض�λ��
%�����
%   U����ֵ��
%   just_rmse���������
%   epsilon_c����״����
%%%%%%%%%%%%%%%%%%%%%
%%  ����ÿ���ֲ��򣬶�ÿ���ֲ���ʩ����Ӧ�Ŀ��Ʒ���
[local_num,local_dis,sub_dis_mat,local_dis_Lrbf,local_inv_rbf,local_shape1]=Local_domain_cal(N,sub_dot_cell,epsilon,floatt);
%% ��װ���ڵ��κ���,��������նȾ���
Shape_func=Overall_matrix_assembly(N,local_num,local_shape1);
%% ѡ���ڵ㸳ֵ�������Ҳࣩ
[u,Lrbf_u]=Calculated_value(N,sub_dot_cell,floatt);
%% ������
U=roundn(Shape_func\u,floatt);
%% ����������
just_rmse=Solution_est_err(N,sub_dot_cell,U,Lrbf_u,local_inv_rbf,local_dis_Lrbf,local_dis);
%% ��״������ֵ
epsilon_c=1./epsilon;
end