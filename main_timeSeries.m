clear all;
t1=clock();

%% ����user-item����ͼ����
%  ��ʱ�����磺
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\unicodelang\out.unicodelang��                           614*254����Ҫת��
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\moreno_crime\out.moreno_crime_crime��                   829*551����Ҫת��
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\brunson_revolution\out.brunson_revolution_revolution��  5*136��  ��Ҫת��
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\bookcrossing_rating\out.bookcrossing_rating_rating,�ܴ󣬲�����
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\filmtrust\ratings.txt��1500*2000
%  
%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\Epinions-665k\ratings_data.txt���ܴ󣬳���
%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\youtube-groupmemberships\out.youtube-groupmemberships,90000*4000,ȥ20/10��Ϊ1500*1200

%  ʱ�����磺
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u.data��                       943*1682,   15s
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-1m\data.txt��                       6000*4000��  6mins���Ľ���
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-frwikibooks\out.edit-frwikibooks����Ҫת�ã� 28113*2884
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-frwikinews\out.edit-frwikinews����Ҫת�ã�   25000*1400
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-wikipedia\out.edit-wikipedia,��Ҫת��,274000*2700(userȥ30��9000*2700��15����)
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\lastfm-2k\user_taggedartists-timestamps.dat,     2000*19000
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\hetrec2011-delicious-2k\user_taggedbookmarks-timestamps.dat��100000*100000
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\opsahl-ucforum\out.opsahl-ucforum,��Ҫת�ã�900*500

%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\escorts\out.escorts��                            10000*6000��2.4mins
%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-10m\out.movielens-10m_rating
%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-enwikiquote\out.edit-enwikiquote,
%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\stackexchange-stackoverflow\out.stackexchange-stackoverflow
% D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\digg-votes\out.digg-votes��140000*3500���ܣ�
% D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\citeulike-ut\out.citeulike-ut�����ܣ�userCF\itemCFûЧ��
% D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\amazon-ratings\out.amazon-ratings�������ܣ�

X = load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\bookcrossing_rating\out.bookcrossing_rating_rating'); % esccort������CFû��ô��Ч
% temp=X(:,1);X(:,1)=X(:,2);X(:,2)=temp;%ĳЩkonect�е�bipartite��user��item���ǵ����˵�
data = X;
% data(:, 3) = 1;
net_rating = spconvert(data(:,[1 2 3]));
prop = datasetProp(net_rating); % ������������
net = spones(net_rating);

%% PNRģ���㷨����
pH = 0.1;       % ���Լ�ռ��
winSize = 7;    % PNR�˲����ڴ�С
bin = 80;        % ����PNR��bin��Ŀ
topL_array = [1 2 3 4 5 10 15 20 25 30 40 50]; % topL�Ƽ�
% topL = 20;      % topL�Ƽ����ԡ�ÿ���û������Ƽ�topL��item����Ȥ�����󣺸������Ƽ�topL"����"low_degree���������Ч��
mu = 0;    % ��̬�ֲ���ֵ
sigma = 20; % ��̬�ֲ�����
hibin = 24; % trick for adjust pnr
train_start_ratio = 0.0;
train_end_ratio = 0.8;
probe_start_ratio = 0.8;
probe_end_ratio = 1.0;
% low_degree = 50; % ��topL��ϵ������low_degree����PNR���Ż�Ӱ����������
%% CF����
K = 20;          % ����user-item similarity�Ĳ������Խ����Ӱ��Ҳ�ܴ�K�����ʹ��PNR������ţ���K̫С���ɽ������״����Ч��
% wikibooksȡ35
%% basicMF����
basicMF_lambda = 8; % ml100k��С������better���������low������С���岻�󣬵���һֱ��
basicMF_feat_num = 5;% Ĭ��Ϊ10��5��30��40���üӴ����laskfm����Ч��������ʱ��
basicMF_maxiter  = 50; %Ĭ��Ϊ20��lastfm��С�������������ǵķ���û������
%% FISM����
FISM_n_lfactors = 50;% ml-100kΪ96��FISM����������������仯����ML1Mʱ��ϳ���
FISM_alpha = 0.5; % ԭ����ml-100k��netflix��yahooΪ0.4-0.5�������������϶��Ǹ������йأ�
%% IBPR����
IBPR_maxIter = 50;% ����������һ����25��������
IBPR_d = 30; % U��V����������ά����
%% MatricCompletion
MC_mu = 0.03;% mu = [0.001,0.01]��һ��Ŷ
MC_rho = 1.5;% rho = [1,5]��2��wikibooks0.9����
MC_maxiter = 50;% Ĭ��Ϊ1000�Σ���50�ε��ٶȲ�ࣩ��50��wikibooks0.9buhao��ML100K0.9�Ӵ�100��΢�Ľ�.
%% PureSVD�Ĳ���
svd_k = 80;     % ����PureSVD�Ĳ���,ml100k=300��200����Ч����ml0.9��10����Ч����,���5��laskfm����,lastfm����Ϊ200��������Ч����
svd_maxit = 50; % lastfm����Ϊ10��������Ч����
%% NMF����
nmf_k = 5; % NMFԭ��MLΪ10-20��maxitΪ20-40
nmf_maxit = 50;
%% PMF����
PMF_maxepoch = 50; % ml1m��50
PMF_num_feat = 10;% ml1m��10
%% BPMF����
BPMF_maxepoch = 50;% ml1mĬ����50
BPMF_num_feat = 50;% ml1mĬ����10��ml100k5�Ϻã�netflixĬ��Ϊfeat30��epoch20-50��

%% ׼����������
recall = zeros(2,length(topL_array));
precision = zeros(2,length(topL_array));
RS_all = zeros(1, 2);
hrResult = zeros(2,length(topL_array));
arhrResult = zeros(2,length(topL_array));

%% ȥ���Ͷȵ�user��item
deg_index = find(sum(net, 2) > 20); % ȥ��user����cosine_user��ȥ��С���û���Ч���úܶ�!!MCȥ��С���û�Ҳ�úܶ�
net = net(deg_index,:);
net_rating = net_rating(deg_index,:);
deg_index = find(sum(net, 1) > 10); % ȥ��item��ȥ������5�Ļ��
net = net(:, deg_index);
net_rating = net_rating(:, deg_index);

%% ʱ�����绮�����ݼ�,0-1ͼ
[train, probe] = DivideNet(net, pH);
% [train, probe] = timeDivideSeg(data, train_start_ratio, train_end_ratio, probe_start_ratio, probe_end_ratio);

% deg_index = find(sum(train, 2) > 2); % ȥ��user����cosine_user��ȥ��С���û���Ч���úܶ�!!MCȥ��С���û�Ҳ�úܶ�
% train = train(deg_index,:);
% probe = probe(deg_index,:);
% net_rating = net_rating(deg_index,:);
% deg_index = find(sum(train, 1) > 2); % ȥ��item��ȥ������5�Ļ��
% train = train(:, deg_index);
% probe = probe(:, deg_index);
% net_rating = net_rating(:, deg_index);

train_rating = train .* net_rating;
probe_rating = probe .* net_rating;

%% ����user-item��score�����ż���PNR
%% ע�⣺������д���ݼ�����rating����Щ�㷨����Ҫrating
% MC\MF\FISM�ȷ�������ͨ��train_rating��train�ֱ���Կ��Ǹ���
sim = jaccard_item_similarity(train); %% wikibooks��pearsonitemЧ���ã���deliciouscoisnuser��;ucform-pearsonuser-k=20ʱ��ʱ��
score = itemCF( train, sim, K); % 4300*5900��Ҫ6����
% score = abs ( BPMF( train_rating, BPMF_maxepoch, BPMF_num_feat) );
% score = abs ( PMF( train_rating, PMF_maxepoch, PMF_num_feat) );
% score = abs ( MatrixCompletion( train ,MC_mu, MC_rho, MC_maxiter) ); % 4300*5900Ҫһ��Сʱ
% score = abs ( FISM( train, FISM_n_lfactors, FISM_alpha) ); % item\userȥ��5
% score = abs ( basicMF( train_rating, basicMF_lambda , basicMF_feat_num, basicMF_maxiter) );
% score = abs ( NMF( train, nmf_k, nmf_maxit) ); % last fm��rating���������岻��
% score = abs ( PureSVD( train , svd_k, svd_maxit) ); % �Ӿ���ֵ

result = hybridDistribution (score, train, bin, [0]); % ��score�������е�0ȥ������ʱ��ȥ��0Ҳ���и��õ�Ч����
alpha =  nnz(probe)/ ( size(train, 1) * size(train, 2) - nnz(train) ); % ������ʹ��PNR�������ֵû��ô��
pnr =    PNR(result(:,5), result(:,6), result(:,1) , alpha);
% pnr = trickPNR( pnr, hibin );

%% ��PNR�����˲�
y = pnr(:,2)';
pnrGau =  [pnr(:,1),  smoothts(y,'g',winSize)'];  % ��˹�˲������ԡ�
pnrMed =  [pnr(:,1),  medfilt1(y,    winSize)'];  % ��ֵ�˲��������ԡ�
pnrMean = [pnr(:,1),  meanFilter(y,  winSize)'];  % ��ֵ�˲������ԡ�
pnrExp =  [pnr(:,1),  smoothts(y,'e',winSize)'];  % ָ�����˲���
plotPNR(pnr(:,1), [pnr(:,2),pnrGau(:,2),pnrMed(:,2),pnrMean(:,2),pnrExp(:,2)]);

%% �޸ķ���
% scorePNR = readjustScore (score, pnr);
% scoreGau = readjustScore (score, pnrGau);
% scoreMed = readjustScore (score, pnrMed);
% scoreMean = readjustScore(score, pnrMean);
% scoreExp = readjustScore (score, pnrExp);
scorePNR = readjustScoreUnique (score, pnr,     mu, sigma);% wikibooks���ݼ�bin1/2/3��Ϊ0���г������
scoreGau = readjustScoreUnique (score, pnrGau,  mu, sigma);
scoreMed = readjustScoreUnique (score, pnrMed,  mu, sigma);
scoreMean = readjustScoreUnique(score, pnrMean, mu, sigma);
scoreExp = readjustScoreUnique (score, pnrExp,  mu, sigma);

for top_index = 1 : 1: length(topL_array)
    topL = topL_array(top_index);
    %% ������׼ȷ�ȡ�����ָ�꣺׼ȷ�ʣ�precision�����ٻ���(recall)��F-Measure��ep(L)��er(L)����ָ�궼�ǻ��������ߣ�
    [p, r, hr, arhr] =                 evaluator( train ,probe, score,    topL);
    [pPNR, rPNR, hrPNR, arhrPNR] =     evaluator( train ,probe, scorePNR, topL);
    [pGau, rGau, hrGau, arhrGau] =     evaluator( train ,probe, scoreGau, topL);
    [pMed, rMed, hrMed, arhrMed] =     evaluator( train ,probe, scoreMed, topL);
    [pMean, rMean, hrMean, arhrMean] = evaluator( train ,probe, scoreMean,topL);
    [pExp, rExp, hrExp, arhrExp] =     evaluator( train ,probe, scoreExp, topL);
    recall(1, top_index)     =  r;
    recall(2, top_index)     =  max([rPNR, rGau, rMed, rMean, rExp]);
    precision(1, top_index)  =  p;
    precision(2, top_index)  =  max([pPNR, pGau, pMed, pMean, pExp]);
    hrResult(1, top_index)   =  hr;
    hrResult(2, top_index)   =  max([hrPNR, hrGau, hrMed, hrMean, hrExp]);
    arhrResult(1, top_index) =  arhr;
    arhrResult(2, top_index) =  max([arhrPNR, arhrGau, arhrMed, arhrMean, arhrExp]);
    
    %% HR
    %     hr =      HR( train ,probe, score,    topL);
    %     hrPNR =   HR( train ,probe, scorePNR, topL);
    %     hrGau =   HR( train ,probe, scoreGau, topL);
    %     hrMed =   HR( train ,probe, scoreMed, topL);
    %     hrMean  = HR( train ,probe, scoreMean,topL);
    %     hrExp =   HR( train ,probe, scoreExp, topL);
    %     hrResult(1, top_index) = hr;
    %     hrResult(2, top_index) = max([hrPNR, hrGau, hrMed, hrMean, hrExp]);
    
    %% ARHR
    %     arhr =      ARHR( train ,probe, score,    topL);
    %     arhrPNR =   ARHR( train ,probe, scorePNR, topL);
    %     arhrGau =   ARHR( train ,probe, scoreGau, topL);
    %     arhrMed =   ARHR( train ,probe, scoreMed, topL);
    %     arhrMean  = ARHR( train ,probe, scoreMean,topL);
    %     arhrExp =   ARHR( train ,probe, scoreExp, topL);
    %     arhrResult(1, top_index) = hr;
    %     arhrResult(2, top_index) = max([hrPNR, hrGau, hrMed, hrMean, hrExp]);
    
    %% ������׼ȷ�ȡ�����ָ�꣺AUC  (��֪��Ϊɶ�����д���)
    % aucPNR = CalcAUC(train, probe, scorePNR);
    % aucGau = CalcAUC(train, probe, scoreGau);
    % aucMed = CalcAUC(train, probe, scoreMed);
    % aucMean = CalcAUC(train, probe, scoreMean);
    % aucExp = CalcAUC(train, probe, scoreExp);
    % auc = CalcAUC(train, probe, score);
end
%% ������׼ȷ�ȡ���ƽ������֣�average ranking score����С
RS =      rankingScore( train, probe, score);
RS_PNR =  rankingScore( train, probe, scorePNR);
RS_Mean = rankingScore( train, probe, scoreMean);
RS_Exp =  rankingScore( train, probe, scoreExp);
RS_Gau =  rankingScore( train, probe, scoreGau);
RS_Med =  rankingScore( train, probe, scoreMed);
RS_all = [RS, min([RS_PNR, RS_Mean, RS_Exp, RS_Gau, RS_Med])];

%% ��ͼ
plotRecallRendering   ( topL_array, recall     );
plotARHRRendering     ( topL_array, arhrResult );
plotPrecisionRendering( topL_array, precision  );

t2=clock();
