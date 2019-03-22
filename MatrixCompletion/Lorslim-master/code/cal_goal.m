function goal = cal_goal(W,X,beta,ro,lambda,V,S,z)
%% Problem
% min 1/2||X-XW||_F^2 + 1/2 beta * ||W||_F^2 +
%  lambda * ||W||_1+z*||W||_{*}+<V,W-S>+1/2 ro||W-S||_F^2
%
%% The main program
    %Normalization 
    As = X;
    mu=mean(X,1);
    nu=(sum(X.^2,1)/size(X,1)).^(0.5); nu=nu';
    As= ( As- repmat(mu, size(As,1),1) ) * diag(nu)^(-1);
    %Calculation
    goal = 1/2*norm(As*W-As,'fro')+1/2*beta*norm(W,'fro')+lambda*norm(W,1)+1/2*ro*norm(W-S,'fro')+sum(sum(V.*(W-S)));
    [u,s,v]=svd(W);
    goal = goal + z*sum(sum(s));
    