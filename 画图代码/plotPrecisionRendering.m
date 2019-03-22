function plotPrecisionRendering( x,precision, method )
precision = precision';
set(0,'defaultfigurecolor','w');    % 设置背景为白色，黑色不适合放在论文里面
xylabelFontsize = 35;      % 定义一个fontsize变量方便以后使用
legendFontsize = 20;
xydataFontsize = 17;
axisWidth = 2.5;
dataWidth = 2.5; % 虚实线的大小
fontName = 'Times New Roman';
resolution = '1000';
markerSize = 8.5;
% plot数据
figure,
plot(x,precision(:,1),'<--b','Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
hold on;
plot(x,precision(:,2),'O-m', 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;

% 设置标签
xlabel('TopN',       'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('Precision@TopN','Fontsize', xylabelFontsize, 'FontName',fontName);

% 设置图例
h=legend( method ,strcat('PNR-', method),'location','NorthEast','FontName',fontName);
set(h,'Fontsize',legendFontsize); 

% 设置坐标轴
set(gca,'looseInset',[0 0 0 0]); % 去掉空白
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth );
set(gca,'XTick',0:5:50);

% 设置高分辨率
% img = gcf;
% print(img, '-dtiff', strcat('-r', resolution), 'C:\Users\zmy201\Desktop\KDD\img.tiff')
end

