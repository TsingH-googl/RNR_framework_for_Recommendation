function [hr,arhr] = LorSLIM(Trainn,test,test_zhong,tol,maxIter,z,ro,lambda,beta)
%% Problem
%
%  min  1/2|| X-XW||_F^2 + 1/2 beta * ||W||_F^2 + lambda * ||W||_1 +
%  z*||W||_{*}
%  s.t.  W >=0
%        diag(W)=0
%
%% Reformulation
%
%  min 1/2||X-XW||_F^2 + 1/2 beta * ||W||_F^2 +
%  lambda * ||W||_1+z*||W||_{*}+<V,W-S>+1/2 ro||W-S||_F^2
%  s.t. W >= 0
%       diag(W)=0
%
%% Input parameters:
%
% Trainn -        Matrix of the training data
% test -         Cell of the testing data excludes rated/purchased one
% test_zhong -       The rated/purchased one in the testing data
% z -        Nuclear norm regularization parameter
% ro -       Parameter associated with the consensus L_2 constraint
% lambda -       L_1 norm regularization parameter
% beta -         L_2 norm regularization parameter
% maxIter -      Maximum number of iterations
% tol -      Tolerance parameter
%
%% Output parameters
% hr -      Matrix of the HR corresponds to N = 5,10,15,20,25
% arhr -        ARHR corresponds to N = 10
%
%% Initialization
%Initialize W,V and S
W = rand(size(Trainn,2));
for i = 1:size(W,1)
    W(i,i) = 0;
end
V = ones(size(Trainn,2));
S = W;
%
%% Training
now_goal = 0;
IterStep = 0;
while(1)
    if IterStep > maxIter
        break
    end
    % Update
    parfor j = 1:size(W,1)
        W(:,j) = nnLeastR1(Trainn,Trainn(:,j),lambda,S(:,j),ro,V(:,j),beta);
    end
    for j = 1:size(W,1)
        W(j,j) = 0;
    end
    S = cal_nuclear(W,V,z,ro);
    V = V+ ro*(W-S);
    IterStep = IterStep + 1;
    last_goal = now_goal;
    now_goal = cal_goal(W,Trainn,beta,ro,lambda,V,S,z);
    if((abs(last_goal - now_goal) < last_goal * tol)&(IterStep>1))
        break
    end
end
[hr,arhr] = cal_res(W,Trainn,test,test_zhong);

    