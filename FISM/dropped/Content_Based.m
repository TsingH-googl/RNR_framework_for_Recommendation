function PredictR = contentbased()
iter=0;
load('matlab1.mat');
maxIter=190;
l = 0.01;
a = 0.00001;
m = 1682;
%W = zeros(943,19);
cnt = 1;
while iter<maxIter
%     for i = 1:943
%         if(mod(cnt,20))==0
            cost = (norm((W*transpose(X) - T).^2))/2 - norm((l*(W.^2)))/2;
            plot(iter,cost,'rx');
            hold all;
%         end
        cnt = cnt + 1;
        W = W - (a)*((W*transpose(X)) - T)*X + (l)*W;
   % end
    iter = iter + 1;
end
 PredictR=W*transpose(X);
end %function