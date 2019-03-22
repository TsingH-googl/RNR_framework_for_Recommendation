clear all;
t1=clock();

%% ����user-item����ͼ����
%  ��ʱ�����磺
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\unicodelang\out.unicodelang��                           614*254����Ҫת��
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\moreno_crime\out.moreno_crime_crime��                   829*551����Ҫת��
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\brunson_revolution\out.brunson_revolution_revolution��  5*136��  ��Ҫת��
%  ʱ�����磺
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u.data��                       943*1682,   15s
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-1m\data.txt��                       6000*4000��  4.5mins���Ľ�ǰ����3mins���Ľ���
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-frwikibooks\out.edit-frwikibooks����Ҫת�ã� 28113*2884
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\escorts\out.escorts��                            10000*6000��2.4mins
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\lastfm-2k\user_taggedartists-timestamps.dat,     2000*19000

X = load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u.data');
% temp=X(:,1);X(:,1)=X(:,2);X(:,2)=temp;%ĳЩkonect�е�bipartite��user��item���ǵ����˵�
data = X(:,[1 2 3 4]);
net = spconvert(data(:,[1 2 3])); % net����rating��Ϣ

%% PNRģ���㷨����
pH = 0.1;       % ���Լ�ռ��
winSize = 7;    % PNR�˲����ڴ�С
bin = 80;        % ����PNR��bin��Ŀ
topL = 10;      % topL�Ƽ����ԡ�ÿ���û������Ƽ�topL��item����Ȥ�����󣺸������Ƽ�topL"����"low_degree���������Ч��
mu = 0;    % ��̬�ֲ���ֵ
sigma = 1; % ��̬�ֲ�����
train_start_ratio = 0.0;
train_end_ratio = 0.6;
probe_start_ratio = 0.6;
probe_end_ratio = 0.7;
% low_degree = 50; % ��topL��ϵ������low_degree����PNR���Ż�Ӱ����������
%% CF����
K = 25;          % ����user-item similarity�Ĳ������Խ����Ӱ��Ҳ�ܴ�K�����ʹ��PNR������ţ���K̫С���ɽ������״����Ч��
% wikibooksȡ35
%% basicMF����
basicMF_lambda = 10;
basicMF_feat_num = 10;
basicMF_maxiter  = 20;
%% FISM����
FISM_n_lfactors = 96;% ml-100kΪ96
FISM_alpha = 0.1; % ml-100kΪ0.4
%% IBPR����
IBPR_maxIter = 50;% ����������һ����25��������
IBPR_d = 30; % U��V����������ά����
%% MatricCompletion
MC_mu = 0.01;% mu = [0.001,0.01]
MC_rho = 5;% rho = [1,5]
MC_maxiter = 20;
%% MFSGD����
iteraTime = 10; % ����MF-SGD�ĵ�������
factor = 30;    % ����MF-SGD�ľ���ֽ�����
num_feature = 100; % RankSGD������Ŀ
%% PureSVD�Ĳ���
svd_k = 500;     % ����PureSVD�Ĳ���,ml100k=300��200����Ч
svd_maxit = 20;
%% NMF����
nmf_k = 30;
nmf_maxit = 50;
%% PMF����
theta = 5; % ��ȷ����ɶ
lambda_u = 0.01;
lambda_v = 0.001;
l= 0.005; % ��ȷ���ǲ���learningRate
num_iters = 10;

%% ʱ�����绮�����ݼ�,0-1ͼ
% [train, probe] = DivideNet(net, pH);
[train, probe] = timeDivideSeg(data, train_start_ratio, train_end_ratio, probe_start_ratio, probe_end_ratio);
% deg_index = find(sum(train, 2) > 0); % ȥ��user����cosine_user��ȥ��С���û���Ч���úܶ�!!
% train = train(deg_index,:);
% probe = probe(deg_index,:);
% net = net(deg_index,:);
% deg_index = find(sum(train, 1) > 0); % ȥ��item
% train = train(:, deg_index);
% probe = probe(:, deg_index);
% net = net(:, deg_index);
train_rating = train .* net;
probe_rating = probe .* net;

%% ����user-item��score�����ż���PNR

% sim = cosine_item_similarity(train);
% score = itemCF( train, sim, K);
score = MatrixCompletion( train ,MC_mu, MC_rho, MC_maxiter);
% score = FISM( train, FISM_n_lfactors, FISM_alpha);
% score = (IBPR( train_rating, IBPR_maxIter, IBPR_d)); % recall��precision��������⣬Ҫע��ʹ�ã���
% score = basicMF( train_rating, basicMF_lambda , basicMF_feat_num, basicMF_maxiter);
% score = MFSGD(train, iteraTime, factor);
% [U,V] = PMF(R,theta,lambda_u,lambda_v,l,num_iters);
% score = U * V';
% score = NMF( train, nmf_k, nmf_maxit);
% score = abs( PureSVD( train , svd_k, svd_maxit) ); % �Ӿ���ֵ����ܴ󣡣�һ��Ҫ�ӣ���

result = hybridDistribution (score, train, bin, [0]); % ��score�������е�0ȥ������ʱ��ȥ��0Ҳ���и��õ�Ч����
alpha =  nnz(probe)/ ( size(train, 1) * size(train, 2) - nnz(train) ); % ������ʹ��PNR�������ֵû��ô��
pnr =    PNR(result(:,5), result(:,6), result(:,1) , alpha);

%% ��PNR�����˲�
y = pnr(:,2)';
pnrGau =  [pnr(:,1),  smoothts(y,'g',winSize)']; % ��˹�˲������ԡ�
pnrMed =  [pnr(:,1),  medfilt1(y,    winSize)'];    % ��ֵ�˲��������ԡ�
pnrMean = [pnr(:,1),  meanFilter(y,  winSize)'];  % ��ֵ�˲������ԡ�
pnrExp =  [pnr(:,1),  smoothts(y,'e',winSize)']; % ָ�����˲���

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

%% ������׼ȷ�ȡ�����ָ�꣺׼ȷ�ʣ�precision�����ٻ���(recall)��F-Measure��ep(L)��er(L)����ָ�궼�ǻ��������ߣ�
[p, r, hr, arhr] =                 evaluator( train ,probe, score,    topL);
[pPNR, rPNR, hrPNR, arhrPNR] =     evaluator( train ,probe, scorePNR, topL);
[pGau, rGau, hrGau, arhrGau] =     evaluator( train ,probe, scoreGau, topL);
[pMed, rMed, hrMed, arhrMed] =     evaluator( train ,probe, scoreMed, topL);
[pMean, rMean, hrMean, arhrMean] = evaluator( train ,probe, scoreMean,topL);
[pExp, rExp, hrExp, arhrExp] =     evaluator( train ,probe, scoreExp, topL);
plotPNR(pnr(:,1), [pnr(:,2),pnrGau(:,2),pnrMed(:,2),pnrMean(:,2),pnrExp(:,2)]);

%% ������׼ȷ�ȡ�����ָ�꣺AUC  (��֪��Ϊɶ�����д���)
% aucPNR = CalcAUC(train, probe, scorePNR);
% aucGau = CalcAUC(train, probe, scoreGau);
% aucMed = CalcAUC(train, probe, scoreMed);
% aucMean = CalcAUC(train, probe, scoreMean);
% aucExp = CalcAUC(train, probe, scoreExp);
% auc = CalcAUC(train, probe, score);

%% ������׼ȷ�ȡ���ƽ������֣�average ranking score����С
RS =      rankingScore( train, probe, score);
RS_PNR =  rankingScore( train, probe, scorePNR);
RS_Mean = rankingScore( train, probe, scoreMean);
RS_Exp =  rankingScore( train, probe, scoreExp);
RS_Gau =  rankingScore( train, probe, scoreGau);
RS_Med =  rankingScore( train, probe, scoreMed);

t2=clock();
