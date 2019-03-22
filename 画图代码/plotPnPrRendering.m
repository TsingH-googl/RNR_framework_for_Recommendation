function plotPnPrRendering(x, pn, pr)

set(0,'defaultfigurecolor','w');    % 设置背景为白色，黑色不适合放在论文里面
xylabelFontsize = 17;      % 定义一个fontsize变量方便以后使用
legendFontsize = 17;
xydataFontsize = 17; % 坐标轴数据
axisWidth = 1.5;
dataWidth = 1.2; % 虚实线的大小
fontName = 'Times New Roman';
resolution = '1000';
markerSize = 5.8;
% 画出各种滤波后的PnPr
figure,
plot(x,pn,'>-', 'color', [1 0 0], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
plot(x,pr,'O-', 'color', [0 0 1], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;

% semilogy(x,pn,'>-', 'color', [1 0 0], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on; % 指数显示
% semilogy(x,pr,'O-', 'color', [0 0 1], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;

% 设置标签
xlabel('s',           'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('Distribution','Fontsize', xylabelFontsize, 'FontName',fontName);

% 设置图例
h = legend('pn(s)','pr(s)','location','NorthEast', 'FontName',fontName); % 设置图例的位置，顺序不要乱
set(h,'Fontsize',legendFontsize);

% 设置坐标轴
set(gca,'looseInset',[0 0 0 0]); % 去掉空白
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth );
set(gca,'XTick',0.0:0.2:max(x));

% xlabel('s');
% ylabel('PNR(s)');
% grid on;
end

