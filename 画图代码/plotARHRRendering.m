function plotARHRRendering( x,arhrResult, method )
arhrResult = arhrResult';
set(0,'defaultfigurecolor','w');    % ���ñ���Ϊ��ɫ����ɫ���ʺϷ�����������
xylabelFontsize = 55;      % ���������ƴ�С
legendFontsize = 30; % ͼ���ֵĴ�С
xydataFontsize = 35; % ���������ִ�С
axisWidth = 5.5; % �������ߴ�С
dataWidth = 5.5; % ��ʵ�ߵĴ�С
fontName = 'Times New Roman';
resolution = '1000';
markerSize = 9.5;
% plot����
figure,
plot(x,arhrResult(:,1),'<--b','Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
hold on;
plot(x,arhrResult(:,2),'O-','color', [0 1 0] ,'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;

% ���ñ�ǩ
xlabel('N',       'Fontsize', xylabelFontsize, 'FontName',fontName, 'FontWeight','bold');
ylabel('ARHR@N','Fontsize', xylabelFontsize, 'FontName',fontName, 'FontWeight','bold');
% xlabel('TopN',       'Fontsize', xylabelFontsize, 'FontName',fontName);
% ylabel('ARHR@TopN','Fontsize', xylabelFontsize, 'FontName',fontName);

% ����ͼ��
h=legend(method,strcat('PNR-', method),'location','SouthEast','FontName',fontName,  'FontWeight','bold');
set(h,'Fontsize',legendFontsize,  'FontWeight','bold'); 

% ����������
set(gca,'looseInset',[0 0 0 0]); % ȥ���հ�
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth, 'FontWeight','bold' );
set(gca,'XTick',0:5:50);

% ����������

% ���ø߷ֱ���
% img = gcf;
% print(img, '-dtiff', strcat('-r', resolution), 'C:\Users\zmy201\Desktop\KDD\img.tiff')
end

