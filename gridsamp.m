function  S = gridsamp(range, q)
%GRIDSAMP  Òç³ö´¦Àí
[mr n] = size(range);    dr = diff(range);
if  mr ~= 2 | any(dr < 0)
  error('range must be an array with two rows and range(1,:) <= range(2,:)')
end 
sq = size(q);
if  min(sq) > 1 | any(q <= 0)
  error('q must be a vector with non-negative elements')
end
p = length(q);   
if  p == 1,  q = repmat(q,1,n); 
elseif  p ~= n
  error(sprintf('length of q must be either 1 or %d',n))
end 

% Check for degenerate intervals
i = find(dr == 0);
if  ~isempty(i),  q(i) = 0*q(i); end

% Recursive computation
if  n > 1
  A = gridsamp(range(:,2:end), q(2:end));  % Recursive call
  [m p] = size(A);   q = q(1);
  S = [zeros(m*q,1) repmat(A,q,1)];
  y = linspace(range(1,1),range(2,1), q);
  k = 1:m;
  for  i = 1 : q
    S(k,1) = repmat(y(i),m,1);  k = k + m;
  end
else    
  S = linspace(range(1,1),range(2,1), q).';
end