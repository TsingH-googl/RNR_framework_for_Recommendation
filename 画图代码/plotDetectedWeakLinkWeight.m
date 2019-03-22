%% �ڲ�ͬ��TopL����ʾrec��rec_PNR������ave
function plotDetectedWeakLinkWeight(train, probe, score, scorePNR)

method='rec';
%% ׼�����ݵ�result��
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

%% ׼����ͼ�Ĳ���
set(0,'defaultfigurecolor','w');    % ���ñ���Ϊ��ɫ����ɫ���ʺϷ�����������
xylabelFontsize = 15;      % ����һ��fontsize���������Ժ�ʹ��
legendFontsize = 15;
xydataFontsize = 15;
axisWidth = 1.0;
fontName = 'Times New Roman';

%% ��ͼ
% plot����
figure,
bar(result,'BarWidth',1.0);% 'stacked'����Ϊһ���ְ�;bar(result,'BarWidth',0.8)
colormap('cool');
hold on;

% ���ñ�ǩ
xlabel('TopN',          'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('Average Scores','Fontsize', xylabelFontsize, 'FontName',fontName);

% ����ͼ��
h=legend(method,strcat('PNR-', method),'location','northeastoutside','FontName',fontName);
set(h,'Fontsize',legendFontsize);

% ����������
set(gca,'looseInset',[0 0 0 0]); % ȥ���հ�
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth ); %���ô�С�������
set(gca,'XTick',0:5:20); % ������
% set(gca,'XTickLabel',{'5', '10', '15', '20'});
% set(gca,'XTickLabel',{'ItemKNN','UserKNN','FISM','MatrixCompletion'}); % ����������
% xtb = get(gca,'XTickLabel');% ��ȡ���������ǩ���
% xt = get(gca,'XTick');% ��ȡ��������̶Ⱦ��
% yt = get(gca,'YTick'); % ��ȡ��������̶Ⱦ��
% xtextp=xt;%ÿ����ǩ����λ�õĺ����꣬�����ȻӦ�ú�ԭ����һ���ˡ�
% ytextp=yt(1)*ones(1,length(xt)); % ������ʾ��ǩ��λ�ã�д����Ψһ��������ʵ����Ϊÿ����ǩ�ҷ���λ�õ�������
% % rotation��������ת�Ƕȴ�����ʱ����ת����ת�������HorizontalAlignment�������趨��
% % ��3������ֵ��left��right��center��������Ը�������ֵ���Լ�rotation��ĽǶȣ�����д����45
% text(xtextp,ytextp,xtb,'HorizontalAlignment','right','rotation',30, 'Fontsize', xylabelFontsize, 'FontName',fontName);
% set(gca,'xticklabel','');% ��ԭ�еı�ǩ��ȥ
end
