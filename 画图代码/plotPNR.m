function plotPNR(x, pnrs)
% 画出各种滤波后的PNR
[m n] = size(pnrs);
figure, hold on;
for i=1:1:n
    switch i
        case 1
            plot(x,pnrs(:,i),'x--k');hold on;
        case 2
            plot(x,pnrs(:,i),'*-g');hold on;
        case 3
            plot(x,pnrs(:,i),'o-r');hold on;
        case 4
            plot(x,pnrs(:,i),'s-b');hold on;
        case 5
            plot(x,pnrs(:,i),'p-m');hold on;
        otherwise
            plot(x,pnrs(:,i),'--y');hold on;
    end
end
legend('PNR','PNR-Gaussina','PNR-Medium','PNR-Mean','PNR-Exp','location','NorthWest'); % 设置图例的位置
xlabel('s');
ylabel('PNR(s)');
% grid on;
end

