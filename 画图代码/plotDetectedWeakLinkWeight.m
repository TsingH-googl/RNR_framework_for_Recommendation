%% 在不同的TopL下显示rec与rec_PNR方法的ave
function plotDetectedWeakLinkWeight(train, probe, score, scorePNR)

method='rec';
%% 准备数据到result中
topL_array = [5,10,15,20];
result = zeros(size(topL_array, 2), 2);
for topL_index = 1:1:length(topL_array)
    ave_weight      = cal_weak_ties_distinction( train, probe, topL_array(topL_index), score, score );
    ave_weight_PNR  = cal_weak_ties_distinction( train, probe, topL_array(topL_index), score, scorePNR );
    % ave_weight_Mean = cal_weak_ties_distinction( train, probe, topL_array(topL_index), score, scoreMean );
    % ave_weight_Med  = cal_weak_ties_distinction( train, probe, topL_array(topL_index), score, scoreMed );
    % ave_weight_Gau  = cal_weak_ties_distinction( train, probe, topL_array(topL_index), score, scoreGau );
    % ave_weight_Exp  = cal_weak_ties_distinction( train, probe, topL_array(topL_index), score, scoreExp );
    
    result(topL_index, 1) = ave_weight;
    % result(topL_index, 2) = min([ave_weight_PNR, ave_weight_Mean, ave_weight_Med, ave_weight_Gau, ave_weight_Exp]);
    result(topL_index, 2) = ave_weight_PNR;
    
end

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
bar(result,'BarWidth',1.0);% 'stacked'参数为一条分半;bar(result,'BarWidth',0.8)
colormap('cool');
hold on;

% 设置标签
xlabel('TopN',          'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('Average Scores','Fontsize', xylabelFontsize, 'FontName',fontName);

% 设置图例
h=legend(method,strcat('PNR-', method),'location','northeastoutside','FontName',fontName);
set(h,'Fontsize',legendFontsize);

% 设置坐标轴
set(gca,'looseInset',[0 0 0 0]); % 去掉空白
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth ); %设置大小、字体等
set(gca,'XTick',0:5:20); % 坏掉了
% set(gca,'XTickLabel',{'5', '10', '15', '20'});
% set(gca,'XTickLabel',{'ItemKNN','UserKNN','FISM','MatrixCompletion'}); % 横坐标文字
% xtb = get(gca,'XTickLabel');% 获取横坐标轴标签句柄
% xt = get(gca,'XTick');% 获取横坐标轴刻度句柄
% yt = get(gca,'YTick'); % 获取纵坐标轴刻度句柄
% xtextp=xt;%每个标签放置位置的横坐标，这个自然应该和原来的一样了。
% ytextp=yt(1)*ones(1,length(xt)); % 设置显示标签的位置，写法不唯一，这里其实是在为每个标签找放置位置的纵坐标
% % rotation，正的旋转角度代表逆时针旋转，旋转轴可以由HorizontalAlignment属性来设定，
% % 有3个属性值：left，right，center，这里可以改这三个值，以及rotation后的角度，这里写的是45
% text(xtextp,ytextp,xtb,'HorizontalAlignment','right','rotation',30, 'Fontsize', xylabelFontsize, 'FontName',fontName);
% set(gca,'xticklabel','');% 将原有的标签隐去
end
