function [ X ] = MC_LogDet_v3(X0,M,rho,kappa,toler,maxiter)

G = X0;
[m,n] = size(X0);
Y = X0;
W = X0;
Theta = zeros(m,n);
Z=zeros(m,n);
for t = 1:maxiter
   
    D = W-Z/rho;
    X = X_Solver_first(D,rho/2);
    
    X(M==1) = G(M==1);
    
    
    W=max(X+ Z/rho,0);
    Z = Z + rho*(X-W);
    rho = rho*kappa;
    
    err = sum(sum((X-X0).^2))/sum(sum(X0.^2));
    
    if err <= toler
        break
    end
    
    X0 = X;
    
end


end
