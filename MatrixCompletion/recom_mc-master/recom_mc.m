%this is the code for AAAI 2016 paper: Top-N Recommender System via Matrix
%Completion by zhao kang,chong peng,qiang cheng.

function [hr,arhr,X] =recom_mc(Trainn,test,test_zhong,mu,rho) 

[m,n]=size(Trainn);
M=Trainn;
id=find(M==0);

ID=ones(m,n);
ID(id)=0;

[ X ] = MC_LogDet_v3(M,ID,mu,rho,1e-10,1000);

%The following part is copied from Cheng's LorSLIM paper code 
 zhong = zeros(1,5);
    po = 0;
REC=X;
hr = zeros(1,5);
    for i = 1:size(Trainn,1)
        value = REC(i,test{i});
        value1 = REC(i,test_zhong(i));
        position = length(find(value > value1)) + 1;
        for n = 5:5:25
            if((position <= n)&(value ~= min(value1)))
                zhong(n/5) = zhong(n/5) + 1;
                if n == 10
                    po = po + 1/position;
                end     
            end
        end
    end
    hr = zhong/size(Trainn,1);
    arhr = po/size(Trainn,1);
end
    
    
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


function [ X ] = X_Solver_first(D,rho)
[U,S,V] = svd(D);
S0 = diag(S);
r = length(S0);
P = [ones(r,1), 1-S0, 1/2/rho-S0];
rt = zeros(r,1);
for t = 1:r    
    p = P(t,:);
    Delta = p(2)^2-4*p(1)*p(3);
    if Delta <= 0
        rt(t) = 0;
    else     
        rts = roots(p);
        rts = sort(rts);
        if rts(1)*rts(2)<=0
            rt(t) = rts(2);
        elseif rts(2)<0
            rt(t) = 0;
        else
            funval = log(1+rts(2))+rho*(rts(2)-S0(t)).^2;
            if funval>log(1+0)+rho*(0-S0(t)).^2;
                rt(t) = 0;
                 else
                rt(t)=rts(2);
            end
        end
    end
end

SSS = diag(rt);
[m,n] = size(D);
sig = zeros(m,n);
sig(1:min(m,n),1:min(m,n)) = SSS;

X = U*sig*V';
end
