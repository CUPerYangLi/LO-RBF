%�˺������ڽڵ�ĵĲ�����N: ��������; s: �ڵ�ֲ���ά��; �ڵ�ֲ�����: 'r'=random
%'u'=uniform;
function [points, N] = CreatePoints(N,s,gridtype)
switch gridtype
    case 'r'%����ֲ��ô���һ��
        bound=ceil(sqrt(N))-1;
        points(1,:)=[0 0];
        points(2,:)=[1 0];
        points(3,:)=[0 1];
        points(4,:)=[1 1];
        bet=1./bound;
        just=4;
        lon=bet;
        while lon-1<bet/2
            just=just+1;
            points(just,:)=[0 lon];
            just=just+1;
            points(just,:)=[lon 0];
            just=just+1;
            points(just,:)=[lon 1];
            just=just+1;
            points(just,:)=[1 lon];
            lon=lon+bet;
        end

        rand('state',47); 
        for i=just+1:1:N
        points(i,:) = rand(1,s);
        end
    case 'u'
        ppd = zeros(1,s);
        for j=1:s
            ppd(j) = floor(nthroot(N,s+1-j));
            N = N/ppd(j);
        end
        points = gridsamp([zeros(1,s); ones(1,s)], ppd);
        N = prod(ppd);
    otherwise
        error('δ֪��ɢ����')
end
