function z=picturecut(x,y,z)
num=size(x);
just=1;
if just==1
for i=1:1:num(1)
    for j=1:1:num(2)
        [theta,amoeba]=cart2pol(x(i,j),y(i,j));
        if amoeba>0.3*(exp(sin(theta)).*(sin(2*theta)).^2+exp(cos(theta)).*(cos(2*theta)).^2);
            z(i,j)=NaN;
        end
    end
end
elseif just==2
    load('lake.txt');% ÔØÈëlakeµÄ×ø±ê
    load('island.txt');
    bdy1=lake./1000;
    bdy2=island./1000;
    bdy=[bdy1;bdy2];
    for i=1:1:num(1)
        xline=x(i,:);
        yline=y(i,:);
        zline=z(i,:);
    [in,on] = inpolygon(xline(1,:), yline(1,:), bdy(:,1), bdy(:,2));
    outner=~in&~on;
    zline(1,outner)=NaN;
    z(i,:)=zline;
    end
end
