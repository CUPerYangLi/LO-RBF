%�˺������ڼ������Ľڵ����ڵ�ľ��룬���Ϊ����
  function DM = DistanceMatrix(dsites,ctrs) 
  [M,s] = size(dsites); [N,s] = size(ctrs);
  DM = zeros(M,N);
  just=1;
  %% ��һ��
  if just==1
      for d=1:s
          [dr,cc] = ndgrid(dsites(:,d),ctrs(:,d));
          DM = DM + (dr-cc).^2;
      end
      DM = sqrt(DM);
      MA=max(max(DM));
      DM=DM./1;
  %% δ��һ��
  else
      for d=1:s
          [dr,cc] = ndgrid(dsites(:,d),ctrs(:,d));
          DM = DM + (dr-cc).^2;
      end
      DM = sqrt(DM);
  end
