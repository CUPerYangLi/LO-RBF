function [nodein,nodeon]=amoeba_node
% �����γ�
clear;
theta=0:0.01:2*pi;
%amoeba=exp(sin(theta)).*(sin(2*theta)).^2+exp(cos(theta)).*(cos(2*theta)).^2;

amoeba=0.3*(exp(sin(theta)).*(sin(2*theta)).^2+exp(cos(theta)).*(cos(2*theta)).^2);

 %figure(1) %����������±��γ�����
% polarplot(theta,amoeba)
[x,y]=pol2cart(theta,amoeba);
% figure(3)% �߽�ڵ�ֲ�����ͼ
theta1=0:0.08:2*pi;

%boundary=exp(sin(theta1)).*(sin(2*theta1)).^2+exp(cos(theta1)).*(cos(2*theta1)).^2;

boundary=0.3*(exp(sin(theta1)).*(sin(2*theta1)).^2+exp(cos(theta1)).*(cos(2*theta1)).^2);

x1=boundary.*cos(theta1);
y1=boundary.*sin(theta1);

% plot(x,y,x1,y1,'*')
%�жϵ��뷶Χ��Ĺ�ϵ
%����㻮�� x,y����[-3,3]*[-2,2]
% [in,on] = inpolygon(xq,yq,xv,yv);�жϵ��ڶ���������ڲ���߽�
x2=-3:0.04:3;
y2=-3:0.04:3;
% x2=-30:0.6:30;
% y2=-20:0.4:20;
[X,Y] = meshgrid(x2,y2);
x_node=reshape(X,1,[]);
y_node=reshape(Y,1,[]);
[in,on] = inpolygon(x_node,y_node,x,y);% in�����˱߽����ڲ���
indot=numel(x_node(in));

nodein(:,1)=x_node(in);
nodein(:,2)=y_node(in);
nodeon(:,1)=x1;
nodeon(:,2)=y1;
nodeall=[nodein;nodeon];
%  figure(2)% ֱ������ϵ�±��γ�����
%  plot(x,y)
%  hold on 
%  scatter(nodeall(:,1),nodeall(:,2))
% figure(4)
%  plot(x,y) % polygon
% axis equal
% hold on
% plot(x,y,x1,y1,'y*');
 %plot(x_node(in),y_node(in),'r*') % points inside
 %plot(x_node(~in),y_node(~in),'b.') % points outside
% hold off
 %plot(node_in(:,1),node_in(:,2))
% 
% %����߽�ڵ���ڲ��ڵ���Ϣ
% bdy=[x1;y1]';
% indot=[x_node(in);y_node(in)]';
% save('amoeba_bdy1','bdy');
% save('amoeba_indot1','indot');
end