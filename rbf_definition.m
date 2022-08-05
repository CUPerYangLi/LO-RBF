% 一个全局径向基函数库
function rbf_definition
global rbf dxrbf dyrbf dxxrbf dxyrbf dyyrbf Lrbf L2rbf
func=1;
if func==1 % Gaussian RBF
    rbf=@(epsilon,r) exp(-(epsilon*r).^2);
    dxrbf=@(epsilon,r,dx) -2*dx*epsilon^2.*exp(-(epsilon*r).^2);   % Gaussian
    dyrbf=@(epsilon,r,dy) -2*dy*epsilon^2.*exp(-(epsilon*r).^2);   % Gaussian
    dxxrbf=@(epsilon,r,dx) 2*epsilon^2*(2*(epsilon*dx).^2-1).*exp(-(epsilon*r).^2);   % Gaussian
    dxyrbf=@(epsilon,r,dx,dy) 4*epsilon^4*dx.*dy.*exp(-(epsilon*r).^2);   % Gaussian
    dyyrbf=@(epsilon,r,dy) 2*epsilon^2*(2*(epsilon*dy).^2-1).*exp(-(epsilon*r).^2);   % Gaussian
    Lrbf=@(epsilon,r) 4*epsilon^2*exp(-(epsilon*r).^2).*((epsilon*r).^2-1);    % Gaussianlaplace二阶导算子
    L2rbf=@(epsilon,r) 16*epsilon^4*(2-4*(epsilon*r).^2+(epsilon*r).^4).*exp(-(epsilon*r).^2);    % Gaussian
elseif func==2% % MQ RBF
    rbf = @(epsilon,r) sqrt(1+(epsilon*r).^2);
    dxrbf = @(epsilon,r,dx) dx*epsilon^2./sqrt(1+(epsilon*r).^2);   % MQ
    dyrbf = @(epsilon,r,dy) dy*epsilon^2./sqrt(1+(epsilon*r).^2);   % MQ
    dxxrbf = @(epsilon,r,dx) epsilon^2*(1+(epsilon*r).^2-(epsilon*dx).^2)./(1+(epsilon*r).^2).^(3/2);   % MQ
    dxyrbf = @(epsilon,r,dx,dy) -epsilon^4*dx.*dy./(1+(epsilon*r).^2).^(3/2);   % MQ
    dyyrbf = @(epsilon,r,dy) epsilon^2*(1+(epsilon*r).^2-(epsilon*dy).^2)./(1+(epsilon*r).^2).^(3/2);   % MQ
    Lrbf = @(epsilon,r) epsilon^2*(2+(epsilon*r).^2)./(1+(epsilon*r).^2).^(3/2);   % MQ
    L2rbf = @(epsilon,r) epsilon^4*((epsilon*r).^4+8*(epsilon*r).^2-8)./(1+(epsilon*r).^2).^(7/2);   % MQ
elseif func==3% IMQ RBF
    rbf = @(epsilon,r) 1./sqrt(1+(epsilon*r).^2);
    dxrbf = @(epsilon,r,dx) -dx*epsilon^2./(1+(epsilon*r).^2).^(3/2);   % IMQ
    dyrbf = @(epsilon,r,dy) -dy*epsilon^2./(1+(epsilon*r).^2).^(3/2);   % IMQ
    dxxrbf = @(epsilon,r,dx) epsilon^2*(3*(epsilon*dx).^2-1-(epsilon*r).^2)./(1+(epsilon*r).^2).^(5/2);   % IMQ
    dxyrbf = @(epsilon,r,dx,dy) 3*epsilon^4*dx.*dy./(1+(epsilon*r).^2).^(5/2);   % IMQ
    dyyrbf = @(epsilon,r,dy) epsilon^2*(3*(epsilon*dy).^2-1-(epsilon*r).^2)./(1+(epsilon*r).^2).^(5/2);   % IMQ
    Lrbf = @(epsilon,r) epsilon^2*((epsilon*r).^2-2)./(1+(epsilon*r).^2).^(5/2);   % IMQ
    L2rbf = @(epsilon,r) 3*epsilon^4*(3*(epsilon*r).^4-24*(epsilon*r).^2+8)./(1+(epsilon*r).^2).^(9/2);   % IMQ
elseif func==4% Wendland C4
    rbf = @(epsilon,r) r.^6.*(35*r.^2-88*r+56*spones(r));    % Wendland C4
    dxrbf = @(epsilon,r,dx) -56*dx*epsilon^2.*max(1-epsilon*r,0).^5.*(5*epsilon*r+1);   % Wendland C4
    dyrbf = @(epsilon,r,dy) -56*dy*epsilon^2.*max(1-epsilon*r,0).^5.*(5*epsilon*r+1);   % Wendland C4
    dxxrbf = @(epsilon,r,dx) 56*epsilon^2*(5*(epsilon*r).^2+30*(epsilon*dx).^2-4*epsilon*r-1).*max(1-epsilon*r,0).^4;   % Wendland C4
    dxyrbf = @(epsilon,r,dx,dy) 1680*epsilon^4*dx.*dy.*max(1-epsilon*r,0).^4;   % Wendland C4
    dyyrbf = @(epsilon,r,dy) 56*epsilon^2*(5*(epsilon*r).^2+30*(epsilon*dy).^2-4*epsilon*r-1).*max(1-epsilon*r,0).^4;   % Wendland C4
    Lrbf = @(epsilon,r) 112*epsilon^2*max(1-epsilon*r,0).^4.*(20*(epsilon*r).^2-4*epsilon*r-1);   % Wendland C4
    L2rbf = @(epsilon,r) 6720*epsilon^4*max(1-epsilon*r,0).^2.*(12*(epsilon*r).^2-11*epsilon*r+2);   % Wendland C4
elseif func==5% Wendland C6
    rbf = @(epsilon,r) r.^8.*(66*spones(r)-154*r+121*r.^2-32*r.^3);    % Wendland C6
    dxrbf = @(epsilon,r,dx) -22*dx*epsilon^2.*max(1-epsilon*r,0).^7.*(16*(epsilon*r).^2+7*epsilon*r+1);   % Wendland C6
    dyrbf = @(epsilon,r,dy) -22*dy*epsilon^2.*max(1-epsilon*r,0).^7.*(16*(epsilon*r).^2+7*epsilon*r+1);   % Wendland C6
    dxxrbf = @(epsilon,r,dx) 22*epsilon^2*max(1-epsilon*r,0).^6.*(16*epsilon^3*(r.^2+9*dx.^2).*r+3*epsilon^2*(8*dx.^2-3*r.^2)-6*epsilon*r-1);   % Wendland C6
    dxyrbf = @(epsilon,r,dx,dy) 528*epsilon^4*dx.*dy.*(max(1-epsilon*r,0).^6.*(6*epsilon*r+1));   % Wendland C6
    dyyrbf = @(epsilon,r,dy) 22*epsilon^2*max(1-epsilon*r,0).^6.*(16*epsilon^3*(r.^2+9*dy.^2).*r+3*epsilon^2*(8*dy.^2-3*r.^2)-6*epsilon*r-1);   % Wendland C6
    Lrbf = @(epsilon,r) 44*epsilon^2*max(1-epsilon*r,0).^6.*(88*(epsilon*r).^3+3*(epsilon*r).^2-6*epsilon*r-1);   % Wendland C6
    L2rbf = @(epsilon,r) 1056*epsilon^4*max(1-epsilon*r,0).^4.*(297*(epsilon*r).^3-212*(epsilon*r).^2+16*epsilon*r+4);   % Wendland C6
end

