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
% PNR =[x,pnr*alpha]; % ����RMSE��һ��Ҫ����Ȩֵalpha������alphaʹ��PNR��С
% PNR([size(pr,1)-4:size(pr,1),], 2) = max(PNR(:,2)) ; % ������Ϊ�Ѹ߷�ֵ��PNR��Ϊ���ֵ(�����۲죬���ָı䲻����Ϊ��ֵ��û��nonlink��)�����Ƿ��֣�����û̫���ô�����������
% figure, plot(x,pnr,'*-');


end

