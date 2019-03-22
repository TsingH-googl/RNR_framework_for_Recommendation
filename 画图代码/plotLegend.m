function plotLegend( x, bin_result, bin_array)
bin_result = bin_result';
set(0,'defaultfigurecolor','w');    % ���ñ���Ϊ��ɫ����ɫ���ʺϷ�����������
xylabelFontsize = 20; % ���������ƴ�С
legendFontsize = 30; % ͼ���ֵĴ�С
xydataFontsize = 15;% ���������ִ�С
axisWidth = 2.5; % �������ߴ�С
dataWidth = 7.2; % ��ʵ�ߵĴ�С

fontName = 'Times New Roman';
resolution = '1000';
markerSize = 25.5; % �ߵı�Ǵ�С
% plot����
figure,
for bin_index = 1:1:size(bin_result, 2)
    switch bin_index
        case 1
            plot(x,bin_result(:,bin_index),'<--','color', [0 0 0], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
        case 2
            plot(x,bin_result(:,bin_index),'O-', 'color', [0.63 0.13 0.94], 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;
        case 3
            plot(x,bin_result(:,bin_index),'>-', 'color', [1 0 0], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
        case 4
            plot(x,bin_result(:,bin_index),'s-', 'color', [0 1 0], 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;
        case 5
            plot(x,bin_result(:,bin_index),'x-', 'color', [0 0 1], 'Linewidth', dataWidth, 'MarkerSize', markerSize);hold on;
        case 6
            plot(x,bin_result(:,bin_index),'*-', 'color', [1 0 1], 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;
        case 7
            plot(x,bin_result(:,bin_index),'v-', 'color', [0 1 1], 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;
        case 8
            plot(x,bin_result(:,bin_index),'^-', 'color', [1 0.38 0.01], 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;
        otherwise
            plot(x,bin_result(:,bin_index),'+-', 'color', [0.01 0.66 0.62], 'Linewidth', dataWidth, 'MarkerSize', markerSize );hold on;
    end
end


% ���ñ�ǩ
xlabel('TopN',     'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('ARHR@TopN','Fontsize', xylabelFontsize, 'FontName',fontName);

% ����ͼ��
str = cell(1, length(bin_array) + 1);
str{1, 1} = 'org';
for i = 2: 1: length(bin_array)+1
    str{1, i} = strcat('b = ', num2str(bin_array(i - 1)));
end
h=legend(str,'location','SouthEast','FontName',fontName);
set(h,'Fontsize',legendFontsize);
set(h,'Box','off');

% columnlegend(9, str,  'location','northwest');

% ����������
set(gca,'looseInset',[0 0 0 0]); % ȥ���հ�
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth); %, 'FontWeight','bold' );
set(gca,'XTick',0:5:50);

% ���ø߷ֱ���
% img = gcf;
% print(img, '-dtiff', strcat('-r', resolution), 'C:\Users\zmy201\Desktop\KDD\img.tiff')
end

