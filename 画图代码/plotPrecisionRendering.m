function plotPrecisionRendering( x,precision, method )
precision = precision';
set(0,'defaultfigurecolor','w');    % ���ñ���Ϊ��ɫ����ɫ���ʺϷ�����������
xylabelFontsize = 35;      % ����һ��fontsize���������Ժ�ʹ��
legendFontsize = 20;
xydataFontsize = 17;
axisWidth = 2.5;
dataWidth = 2.5; % ��ʵ�ߵĴ�С
fontName = 'Times New Roman';
resolution = '1000';
markerSize = 8.5;
% plot����
figure,
plot(x,precision(:,1),'<--b','Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
hold on;
plot(x,precision(:,2),'O-m', 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;

% ���ñ�ǩ
xlabel('TopN',       'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('Precision@TopN','Fontsize', xylabelFontsize, 'FontName',fontName);

% ����ͼ��
h=legend( method ,strcat('PNR-', method),'location','NorthEast','FontName',fontName);
set(h,'Fontsize',legendFontsize); 

% ����������
set(gca,'looseInset',[0 0 0 0]); % ȥ���հ�
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth );
set(gca,'XTick',0:5:50);

% ���ø߷ֱ���
% img = gcf;
% print(img, '-dtiff', strcat('-r', resolution), 'C:\Users\zmy201\Desktop\KDD\img.tiff')
end

