function [U,just_rmse,epsilon_c]=PO_min(N0,sub_dot_cell,floatt,local_rmse)
%����Ⱥ�㷨ʵ������������Сֵ
%% ��ʼ������
N = 10;                         % ��ʼ��Ⱥ����
d = 1;                          % �ռ�ά��
ger = 20;                      % ����������
limit = [0, 1];                % ����λ�ò�������
vlimit = [-0.1, 0.1];               % �����ٶ�����
w = 0.6;                        % ����Ȩ��
c1 = 0.5;                       % ����ѧϰ����
c2 = 0.5;                       % Ⱥ��ѧϰ����
for i = 1:d
    x = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, d);%��ʼ��Ⱥ��λ��
end
v = rand(N, d);                  % ��ʼ��Ⱥ���ٶ�
xm = x;                          % ÿ���������ʷ���λ��
ym = zeros(1, d);                % ��Ⱥ����ʷ���λ��
fxm = zeros(N, 1);               % ÿ���������ʷ�����Ӧ��
fym = 0;                      % ��Ⱥ��ʷ�����Ӧ��
%% Ⱥ�����
iter = 1;
record = zeros(ger, 1);          % ��¼��
x0=local_rmse(:,1);
y0=local_rmse(:,2);
while iter <= ger
    for i=1:N
        [U0,just_rmse0,epsilon_c0]=LO_RBF_err(N0,1./x(i),sub_dot_cell,floatt);% ���嵱ǰ��Ӧ��
        fx(i)=1./just_rmse0;
    end
    for i = 1:N
        if fxm(i) < fx(i)
            fxm(i) = fx(i);     % ���¸�����ʷ�����Ӧ��
            
            xm(i,:) = x(i,:);   % ���¸�����ʷ���λ��
        end
    end
    if fym < max(fxm)
        [fym, nmax] = max(fxm);   % ����Ⱥ����ʷ�����Ӧ��
        ym = xm(nmax, :);      % ����Ⱥ����ʷ���λ��
        best_x(iter)=1./fx(nmax);
    end
    v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% �ٶȸ���
    % �߽��ٶȴ���
    for i=1:N
        if v(i) > vlimit(2)
            v(i)= vlimit(2);
        elseif v(i) < vlimit(1)
            v(i)= vlimit(1);
        end
    end
    x = x + v;% λ�ø���
    % �߽�λ�ô���
    for i=1:N
        if x(i)>limit(2)
            x(i)=limit(2);
        elseif x(i)<limit(1)
            x(i)=limit(1);
        end
    end
    record(iter) = fym;%���ֵ��¼
    for i=1:N
        [U0,just_rmse0,epsilon_c0]=LO_RBF_err(N0,1./x(i),sub_dot_cell,floatt);% ���嵱ǰ��Ӧ��
        fx(i)=1./just_rmse0;
    end
    %semilogy(x0, y0, 'b-',x, 1./fx, 'ro');title('����ͼ'),
    createfigure2D_PO(x0,y0,x,1./fx,iter),
     pause(0.1)
    iter = iter+1;
end
figure2 = figure;
plot(best_x);
xlabel('��������');
[U,just_rmse,epsilon_c]=LO_RBF_err(N0,1./ym,sub_dot_cell,floatt);
end


