
function Figure_result(exact,U,local_rmse,epsilon_rmse,nodes)
%%%%%%%%%%%%%%%%%%%%
%���������������������ʾ
%���룺
%   exact����ʵ��
%   U����ֵ��
%   floatt:�ض�λ��
%   local_rmse���������
%   epsilon_rmse����ʵ���
%   nodes���ڵ�����
%%%%%%%%%%%%%%%%%%%%%
a=size(nodes,1);
X=zeros(1,a);
Y=zeros(1,a);
Z=zeros(1,a);
u2=zeros(1,a);
for i=1:1:a
    X(i)=nodes(i,2);
    Y(i)=nodes(i,3);
    Z(i)=U(i);
    u2(i)=exact(i);   
end
[x1,y1,z1]=griddata(X,Y,Z,linspace(min(X),max(X))',linspace(min(Y),max(Y)),'linear');
[x2,y2,z2]=griddata(X,Y,u2,linspace(min(X),max(X))',linspace(min(Y),max(Y)),'linear');
createfigure2D(local_rmse(:,1),local_rmse(:,2)),axis([0 1 0.001 100000000]),
%title('createfigure2D example'),ylabel('example');
title('Error estimation'),ylabel('Estimated RMS error');
createfigure2D(epsilon_rmse(:,1),epsilon_rmse(:,2)),axis([0 1 0.00001 1000000]),title('Actual RMS error'),ylabel('RMS error');
createfigure(x1,y1,z1),
%title('createfigure example');
title('LRBF(c=2)');
createfigure(x2,y2,z2),title('Analytical solution');
figure,scatter(X,Y);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function createfigure2D(X1, Y1)
%CREATEFIGURE1(X1, Y1)
%  X1:  x ���ݵ�ʸ��
%  Y1:  y ���ݵ�ʸ��
% ���� figure
figure1 = figure;
% ���� axes
axes1 = axes('Parent',figure1,...
    'Position',[0.13 0.111324503311258 0.775 0.815]);
hold(axes1,'on');
% ���� semilogy
semilogy(X1,Y1,'ZDataSource','','MarkerSize',4,'Marker','o','LineWidth',1);
% ���� xlabel
xlabel({'c'},'FontWeight','bold','FontSize',20,'FontName','Times New Roman');
% ���� title
title({'Actual RMS error'},'FontSize',20,'FontName','Times New Roman');
% ���� ylabel
ylabel({'RMS error'},'FontWeight','bold','FontSize',20,...
    'FontName','Times New Roman');
% ȡ�������е�ע���Ա���������� X ��Χ
 xlim(axes1,[0 1.5]);
% ȡ�������е�ע���Ա���������� Y ��Χ
% ylim(axes1,[1e-05 1000000]);
box(axes1,'on');
% ������������������
set(axes1,'LineWidth',1,'XGrid','on','XMinorTick','on','XTick',...
    [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5],'YGrid','on',...
    'YMinorGrid','on','YMinorTick','on','YScale','log');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function createfigure(xdata1, ydata1, zdata1)
%ͼ��������(XDATA1, YDATA1, ZDATA1)
%  XDATA1:  surface xdata
%  YDATA1:  surface ydata
%  ZDATA1:  surface zdata
% ���� figure
figure1=figure
% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
% ���� surf
surf(xdata1,ydata1,zdata1,'Parent',axes1,'LineWidth',0.8);
% ���� xlabel
xlabel({'X1'},'FontWeight','bold','FontSize',20,...
    'FontName','Times New Roman');
% ���� zlabel
zlabel({'Y'},'FontWeight','bold','FontSize',20,'FontName','Times New Roman');
% ���� title
title('Analytical solution','FontWeight','bold','FontSize',20,...
    'FontName','Times New Roman');
% ���� ylabel
ylabel({'X2'},'HorizontalAlignment','center','FontWeight','bold',...
    'FontSize',20,...
    'FontName','Times New Roman');
% ȡ�������е�ע���Ա���������� Z ��Χ
% zlim(axes1,[-2 3]);
view(axes1,[-37.5 30]);
grid(axes1,'on');
% ������������������
set(axes1,'GridAlpha',0.5,'LineWidth',1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function createfigure2D_PO(X1, Y1, X2, Y2)
%CREATEFIGURE1(X1, Y1)
%  X1:  x ���ݵ�ʸ��
%  Y1:  y ���ݵ�ʸ��
% ���� figure
close all
figure1 = figure;
% ���� axes
 axes1 = axes('Parent',figure1,...
     'Position',[0.13 0.111324503311258 0.775 0.815]);
 hold(axes1,'on');
% ���� semilogy
semilogy(X1,Y1,'ZDataSource','','MarkerEdgeColor','none','MarkerSize',4,...
    'Marker','o',...
    'LineWidth',1);
% ���� semilogy
semilogy(X2,Y2,'MarkerEdgeColor',[1 0 0],'MarkerSize',10,'Marker','o');
% ���� xlabel
xlabel({'c'},'FontWeight','bold','FontSize',20,'FontName','Times New Roman');
% ���� title
title({'Actual RMS error'},'FontSize',20,'FontName','Times New Roman');
% ���� ylabel
ylabel({'RMS error'},'FontWeight','bold','FontSize',20,...
    'FontName','Times New Roman');
% ȡ�������е�ע���Ա���������� X ��Χ
% xlim(axes1,[0 1]);
box(axes1,'on');
ax.YMinorGrid = 'off';
ax.YMinorTick = 'off';
% ������������������
set(axes1,'LineWidth',1,'XGrid','on','XMinorTick','on','XTick',...
    [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5],'YGrid','on',...
    'YScale','log');
end