function plotPNRRendering(x, pnrs)

set(0,'defaultfigurecolor','w');    % ���ñ���Ϊ��ɫ����ɫ���ʺϷ�����������
xylabelFontsize = 17;      % ����һ��fontsize���������Ժ�ʹ��
legendFontsize = 17;
xydataFontsize = 17; % ����������
axisWidth = 1.5;
dataWidth = 1.2; % ��ʵ�ߵĴ�С
fontName = 'Times New Roman';
resolution = '1000';
markerSize = 5.8;
% ���������˲����PNR
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

% ���ñ�ǩ
xlabel('s',     'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('PNR(s)','Fontsize', xylabelFontsize, 'FontName',fontName);

% ����ͼ��
h = legend('PNR-free','PNR-Gaussina','PNR-Medium','PNR-Mean','PNR-Exp','location','NorthWest', 'FontName',fontName); % ����ͼ����λ�ã�˳��Ҫ��
set(h,'Fontsize',legendFontsize);

% ����������
set(gca,'looseInset',[0 0 0 0]); % ȥ���հ�
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth );
set(gca,'XTick',0.0:0.2:1.0);

% xlabel('s');
% ylabel('PNR(s)');
% grid on;
end

