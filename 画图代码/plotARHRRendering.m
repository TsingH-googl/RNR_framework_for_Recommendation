function plotARHRRendering( x,arhrResult, method )
arhrResult = arhrResult';
set(0,'defaultfigurecolor','w');    % 设置背景为白色，黑色不适合放在论文里面
xylabelFontsize = 55;      % 坐标轴名称大小
legendFontsize = 30; % 图例字的大小
xydataFontsize = 35; % 坐标轴数字大小
axisWidth = 5.5; % 坐标轴线大小
dataWidth = 5.5; % 虚实线的大小
fontName = 'Times New Roman';
resolution = '1000';
markerSize = 9.5;
% plot数据
figure,
plot(x,arhrResult(:,1),'<--b','Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
hold on;
plot(x,arhrResult(:,2),'O-','color', [0 1 0] ,'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;

% 设置标签
xlabel('N',       'Fontsize', xylabelFontsize, 'FontName',fontName, 'FontWeight','bold');
ylabel('ARHR@N','Fontsize', xylabelFontsize, 'FontName',fontName, 'FontWeight','bold');
% xlabel('TopN',       'Fontsize', xylabelFontsize, 'FontName',fontName);
% ylabel('ARHR@TopN','Fontsize', xylabelFontsize, 'FontName',fontName);

% 设置图例
h=legend(method,strcat('PNR-', method),'location','SouthEast','FontName',fontName,  'FontWeight','bold');
set(h,'Fontsize',legendFontsize,  'FontWeight','bold'); 

% 设置坐标轴
set(gca,'looseInset',[0 0 0 0]); % 去掉空白
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth, 'FontWeight','bold' );
set(gca,'XTick',0:5:50);

% 设置网格线

% 设置高分辨率
% img = gcf;
% print(img, '-dtiff', strcat('-r', resolution), 'C:\Users\zmy201\Desktop\KDD\img.tiff')
end

