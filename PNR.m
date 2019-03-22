function  PNR = PNR(pr, pn, x, alpha)
bin_number = length(pr);
pnr = zeros(bin_number,1);
for i =1 :1 :bin_number
    if(pn(i) == 0)
        pnr(i) = 0;
        continue
    else
    pnr(i) = (pr(i)/pn(i));
    end
end

PNR =[x,pnr]; 
% PNR =[x,pnr*alpha]; % 计算RMSE则一定要加上权值alpha，乘上alpha使得PNR变小
% PNR([size(pr,1)-4:size(pr,1),], 2) = max(PNR(:,2)) ; % 这里认为把高分值的PNR置为最高值(经过观察，发现改变不大，因为高值是没有nonlink的)，但是发现，基本没太大用处，反而降低
% figure, plot(x,pnr,'*-');


end

