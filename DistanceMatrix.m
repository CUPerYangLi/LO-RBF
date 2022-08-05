%此函数用于计算中心节点和配节点的距离，输出为矩阵
  function DM = DistanceMatrix(dsites,ctrs) 
  [M,s] = size(dsites); [N,s] = size(ctrs);
  DM = zeros(M,N);
  just=1;
  %% 归一化
  if just==1
      for d=1:s
          [dr,cc] = ndgrid(dsites(:,d),ctrs(:,d));
          DM = DM + (dr-cc).^2;
      end
      DM = sqrt(DM);
      MA=max(max(DM));
      DM=DM./1;
  %% 未归一化
  else
      for d=1:s
          [dr,cc] = ndgrid(dsites(:,d),ctrs(:,d));
          DM = DM + (dr-cc).^2;
      end
      DM = sqrt(DM);
  end
