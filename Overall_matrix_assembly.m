function Shape_func=Overall_matrix_assembly(N,local_num,local_shape1)
%%%%%%%%%%%%%%%%%%%%
%�����������װ�����������նȾ��󣬰������ĵ��Ӧ�ı�Ž�ÿ���ֲ���Ĺ�ϵʽǶ������նȾ���
%���룺
%   N���ֲ�������
%   local_num��ÿ���ֲ������ĵ�ı��
%   local_shape1:ÿ���ֲ���Ĺ�ϵʽ
%�����
%   Shape_func�����ɵ�����նȾ���
%%%%%%%%%%%%%%%%%%%%%
Shape_func=zeros(N,N);
for i=1:N
    indx=local_num{i};
    Shape_func(i,indx)=local_shape1{i};
end
end
