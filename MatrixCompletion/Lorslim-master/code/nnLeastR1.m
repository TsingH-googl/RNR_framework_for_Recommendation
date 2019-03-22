function [x, funVal]=nnLeastR1(A, y, lambda, s, ro,V,beta)
%% Problem
%
%  min  1/2 || A x - y||^2 + 1/2 beta * ||x||_2^2 + lambda * ||x||_1
%  +1/2 ro*||x-s||^2+<V,x-s>
%  s.t.  x >=0
%
%% Input parameters:
%
%  A-         Matrix of size m x n
%  y -        Response vector 
%  lambda -        L_1 norm regularization parameter
%  s -      Introduced matrix
%  ro -     Parameter associated with the consensus L_2 constraint
%  V -      Parameter associated with the consensus product constraint
%  beta -    L_2 norm regularization parameter  
%  x -      Previous value of solution
%% Output parameters:
%  x-         Solution
%  funVal-    Function value during iterations
%
%% Normalilambdaation
%
[m,n] = size(A);
mu=mean(A,1); 
nu=(sum(A.^2,1)/m).^(0.5); nu=nu';
% If some values in nu is typically small,we set the corresponding value to
% 1 for numerical stability.
ind =find(abs(nu)<= 1e-10);    
nu(ind)=1;
%    
%% Starting point initialilambdaation
%
ATy=A'*y - sum(y) * mu'; 
ATy=ATy./nu;
x=abs(ATy);
invNu=x./nu; mu_invNu=mu * invNu;
Ax=A*invNu -repmat(mu_invNu, m, 1);
x_norm=sum(abs(x)); x_2norm=x'*x;
if x_norm>=1e-6
    ratio=initFactor(x_norm, Ax, y, lambda,'nnLeastR', beta, x_2norm);
    x=ratio*x;    Ax=ratio*Ax;
end
%

%% The main program

bFlag=0; % this flag tests whether the gradient step only changes a little

gamma=1 + beta+ro+sum(V);

% assign xp with x, and Axp with Ax
xp=x; Axp=Ax; xxp=zeros(n,1);

 % tp and t are used for computing the weight in forming search point
tp=0; t=1;

% tol is the tolerance parameter, maxIter is the maximum number of iterations
tol = 1e-3;
maxIter=10000;

for iterStep=1:maxIter
    % --------------------------- step 1 ---------------------------
    % compute search point sr based on xp and x (with alpha)
    alpha=(tp-1)/t;    sr=x + alpha* xxp;

    % --------------------------- step 2 ---------------------------
    % line search for gamma and compute the new approximate solution x

    % compute the gradient (g) at sr
    As=Ax + alpha* (Ax-Axp);

    % compute AT As
    ATAs=A'*As - sum(As) * mu'; 
    ATAs=ATAs./nu;
    
    % obtain the gradient g
    g=ATAs-ATy + beta * sr + V + ro*(x-s);

    % copy x and Ax to xp and Axp
    xp=x;    
    Axp=Ax;

    while (1)
        % let sr walk in a step in the antigradient of s to get v
        % and then do the l1-norm regularilambdaed projection
        v=sr-g/gamma;

        % L1-norm regularilambdaed projection (with constraint x>=0)
        x=max(v-lambda / gamma,0); % considering the constraint x>=0

        v=x-sr;  % the difference between the new approximate solution x
                % and the search point sr

        % compute Ax
        invNu=x./nu; mu_invNu=mu * invNu;
        Ax=A*invNu -repmat(mu_invNu, m, 1);
        Av=Ax -As;
        r_sum=v'*v; l_sum=Av'*Av;
        % The gradient step makes little improvement
        if (r_sum <=1e-20)
            bFlag=1;
            break;
        end
        
        % Terminal condition
        if(l_sum+2*sum(V.*v) <= r_sum * (gamma-beta-ro))
            break;
        else
            gamma=max(2*gamma, (l_sum+2*sum(V.*v))/r_sum + beta+ro);
        end
    end

    % --------------------------- step 3 ---------------------------
    % update t and tp, and check whether converge
    tp=t; t= (1+ sqrt(4*t*t +1))/2;

    xxp=x-xp;   Axy=Ax-y;
    funVal(iterStep)=Axy'* Axy/2 + beta/2 * x'*x + sum(x) * lambda + ro/2 * (x-s)'*(x-s) + sum(V.*(x-s));
    
    if (bFlag)
        break;
    end

    if iterStep>=2
        if (abs( funVal(iterStep) - funVal(iterStep-1) ) <= tol)
            break;
        end
    end
            
end