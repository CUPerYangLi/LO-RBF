function createfigure2D_PO(X1, Y1, X2, Y2,i)
%����Ⱥ���������ʾ
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
semilogy(X2,Y2,'MarkerEdgeColor',[1 0 0],'MarkerSize',10,'Marker','o',...
    'LineWidth',2,...
    'LineStyle','none');
% ���� xlabel
xlabel({'c'},'FontWeight','bold','FontSize',20,'FontName','Times New Roman');
% ���� title
title({['PSO,Update=', num2str(i)]},'FontSize',20,'FontName','Times New Roman');
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
    'YMinorTick','on','YScale','log');
