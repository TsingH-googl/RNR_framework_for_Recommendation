%% ��ͬһ��TopL����ʾrec��rec_PNR������ave
function plotDetectedWeakLinkWeight2(result)

method = 'rec';
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
b = bar(result,'BarWidth',0.95);% 'stacked'����Ϊһ���ְ�;bar(result,'BarWidth',0.8)
% b(1).EdgeColor = 'blue';
b(1).FaceColor = '[0 0.7 0.7]'; 
% b(2).EdgeColor = 'red';
b(2).FaceColor = '[1 0.2 0]';
hold on;

% ����������б��
% applyhatch(gcf,'\');

% ���ñ�ǩ
% xlabel('TopN',          'Fontsize', xylabelFontsize, 'FontName',fontName);
ylabel('Average Scores','Fontsize', xylabelFontsize, 'FontName',fontName);

% ����ͼ��
h=legend(method,strcat('PNR-', method),'location','northeastoutside','FontName',fontName);
set(h,'Fontsize',legendFontsize);

% ����������
set(gca,'YTick',[0.0:0.2:1.0]);   % �޸�y��������

% ����������
set(gca,'looseInset',[0 0 0 0]); % ȥ���հ�
set(gca,'FontName' ,fontName, 'FontSize' ,xydataFontsize, 'LineWidth', axisWidth ); %���ô�С�������
set(gca,'XTickLabel',{'ItemKNN','UserKNN','FISM','MatrixCompletion','PureSVD', 'BPMF'}); % ����������
xtb = get(gca,'XTickLabel');% ��ȡ���������ǩ���
xt = get(gca,'XTick');% ��ȡ��������̶Ⱦ��
yt = get(gca,'YTick'); % ��ȡ��������̶Ⱦ��
xtextp=xt;%ÿ����ǩ����λ�õĺ����꣬�����ȻӦ�ú�ԭ����һ���ˡ�
ytextp=yt(1)*ones(1,length(xt)); % ������ʾ��ǩ��λ�ã�д����Ψһ��������ʵ����Ϊÿ����ǩ�ҷ���λ�õ�������
% rotation��������ת�Ƕȴ�����ʱ����ת����ת�������HorizontalAlignment�������趨��
% ��3������ֵ��left��right��center��������Ը�������ֵ���Լ�rotation��ĽǶȣ�����д����45
text(xtextp,ytextp,xtb,'HorizontalAlignment','right','rotation',30, 'Fontsize', xylabelFontsize, 'FontName',fontName);
set(gca,'xticklabel','');% ��ԭ�еı�ǩ��ȥ
end
