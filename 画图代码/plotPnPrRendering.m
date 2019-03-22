function plotPnPrRendering(x, pn, pr)

set(0,'defaultfigurecolor','w');    % ���ñ���Ϊ��ɫ����ɫ���ʺϷ�����������
xylabelFontsize = 17;      % ����һ��fontsize���������Ժ�ʹ��
legendFontsize = 17;
xydataFontsize = 17; % ����������
axisWidth = 1.5;
dataWidth = 1.2; % ��ʵ�ߵĴ�С
fontName = 'Times New Roman';
resolution = '1000';
markerSize = 5.8;
% ���������˲����PnPr
figure,
plot(x,pn,'>-', 'color', [1 0 0], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
plot(x,pr,'O-', 'color', [0 0 1], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;

% semilogy(x,pn,'>-', 'color', [1 0 0], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on; % ָ����ʾ
% semilogy(x,pr,'O-', 'color', [0 0 1], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;

% ���ñ�ǩ
xlabel('s',           'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('Distribution','Fontsize', xylabelFontsize, 'FontName',fontName);

% ����ͼ��
h = legend('pn(s)','pr(s)','location','NorthEast', 'FontName',fontName); % ����ͼ����λ�ã�˳��Ҫ��
set(h,'Fontsize',legendFontsize);

% ����������
set(gca,'looseInset',[0 0 0 0]); % ȥ���հ�
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth );
set(gca,'XTick',0.0:0.2:max(x));

% xlabel('s');
% ylabel('PNR(s)');
% grid on;
end

