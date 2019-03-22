function plotPNRRendering(x, pnrs)

set(0,'defaultfigurecolor','w');    % 设置背景为白色，黑色不适合放在论文里面
xylabelFontsize = 17;      % 定义一个fontsize变量方便以后使用
legendFontsize = 17;
xydataFontsize = 17; % 坐标轴数据
axisWidth = 1.5;
dataWidth = 1.2; % 虚实线的大小
fontName = 'Times New Roman';
resolution = '1000';
markerSize = 5.8;
% 画出各种滤波后的PNR
[m n] = size(pnrs);
figure, 
for i=1:1:n
    switch i
        case 1
            plot(x,pnrs(:,i),'<--','color', [0 0 0], 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;
        case 2
            plot(x,pnrs(:,i),'s-', 'color', [0 1 0], 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;
        case 3
            plot(x,pnrs(:,i),'v-', 'color', [1 0 0], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
        case 4
            plot(x,pnrs(:,i),'*-', 'color', [1 0 1], 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;
        case 5
            plot(x,pnrs(:,i),'O-', 'color', [0 0 1], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
        otherwise
            plot(x,pnrs(:,i),'+-', 'color', [0.01 0.66 0.62], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
    end
end

% 设置标签
xlabel('s',     'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('PNR(s)','Fontsize', xylabelFontsize, 'FontName',fontName);

% 设置图例
h = legend('PNR-free','PNR-Gaussina','PNR-Medium','PNR-Mean','PNR-Exp','location','NorthWest', 'FontName',fontName); % 设置图例的位置，顺序不要乱
set(h,'Fontsize',legendFontsize);

% 设置坐标轴
set(gca,'looseInset',[0 0 0 0]); % 去掉空白
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth );
set(gca,'XTick',0.0:0.2:1.0);

% xlabel('s');
% ylabel('PNR(s)');
% grid on;
end

