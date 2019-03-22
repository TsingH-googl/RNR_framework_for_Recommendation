function score = recMC( Trainn ,mu,rho ) % mu = [0.001,0.01], rho = [1,5]
%this is the code for AAAI 2016 paper: Top-N Recommender System via Matrix
%Completion by zhao kang,chong peng,qiang cheng.

[m,n]=size(Trainn);
M=Trainn;
id=find(M==0);

ID=ones(m,n);
ID(id)=0;

[ X ] = MC_LogDet_v3(M,ID,mu,rho,1e-10,1000);
score =X;

end
