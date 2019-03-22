%% 在同一的TopL下显示rec与rec_PNR方法的ave
function plotDetectedWeakLinkWeight2(result)

method = 'rec';
%% 准备画图的参数
set(0,'defaultfigurecolor','w');    % 设置背景为白色，黑色不适合放在论文里面
xylabelFontsize = 15;      % 定义一个fontsize变量方便以后使用
legendFontsize = 15;
xydataFontsize = 15;
axisWidth = 1.0;
fontName = 'Times New Roman';

%% 画图
% plot数据
figure,
b = bar(result,'BarWidth',0.95);% 'stacked'参数为一条分半;bar(result,'BarWidth',0.8)
% b(1).EdgeColor = 'blue';
b(1).FaceColor = '[0 0.7 0.7]'; 
% b(2).EdgeColor = 'red';
b(2).FaceColor = '[1 0.2 0]';
hold on;

% 设置柱子内斜线
% applyhatch(gcf,'\');

% 设置标签
% xlabel('TopN',          'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('Average Scores','Fontsize', xylabelFontsize, 'FontName',fontName);

% 设置图例
h=legend(method,strcat('PNR-', method),'location','northeastoutside','FontName',fontName);
set(h,'Fontsize',legendFontsize);

% 设置坐标间隔
set(gca,'YTick',[0.0:0.2:1.0]);   % 修改y轴坐标间隔

% 设置坐标轴
set(gca,'looseInset',[0 0 0 0]); % 去掉空白
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth ); %设置大小、字体等
set(gca,'XTickLabel',{'ItemKNN','UserKNN','FISM','MatrixCompletion','PureSVD', 'BPMF'}); % 横坐标文字
xtb = get(gca,'XTickLabel');% 获取横坐标轴标签句柄
xt = get(gca,'XTick');% 获取横坐标轴刻度句柄
yt = get(gca,'YTick'); % 获取纵坐标轴刻度句柄
xtextp=xt;%每个标签放置位置的横坐标，这个自然应该和原来的一样了。
ytextp=yt(1)*ones(1,length(xt)); % 设置显示标签的位置，写法不唯一，这里其实是在为每个标签找放置位置的纵坐标
% rotation，正的旋转角度代表逆时针旋转，旋转轴可以由HorizontalAlignment属性来设定，
% 有3个属性值：left，right，center，这里可以改这三个值，以及rotation后的角度，这里写的是45
text(xtextp,ytextp,xtb,'HorizontalAlignment','right','rotation',30, 'Fontsize', xylabelFontsize, 'FontName',fontName);
set(gca,'xticklabel','');% 将原有的标签隐去
end
