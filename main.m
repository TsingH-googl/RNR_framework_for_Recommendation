clear all;
t1=clock();

%% 读入user-item二分图数据
%  非时序网络：
%  D:\链路预测相关课题\基于用户-物品的推荐\无时间上下文信息数据集\unicodelang\out.unicodelang，                           614*254，需要转置
%  D:\链路预测相关课题\基于用户-物品的推荐\无时间上下文信息数据集\moreno_crime\out.moreno_crime_crime，                   829*551，需要转置
%  D:\链路预测相关课题\基于用户-物品的推荐\无时间上下文信息数据集\brunson_revolution\out.brunson_revolution_revolution，  5*136，  需要转置
%  时序网络：
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-100k\u.data，                       943*1682,   15s
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-1m\data.txt，                       6000*4000，  4.5mins（改进前），3mins（改进后）
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\edit-frwikibooks\out.edit-frwikibooks，需要转置， 28113*2884
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\escorts\out.escorts，                            10000*6000，2.4mins
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\lastfm-2k\user_taggedartists-timestamps.dat,     2000*19000

X = load('D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-1m\data.txt');
% temp=X(:,1);X(:,1)=X(:,2);X(:,2)=temp;%某些konect中的bipartite的user与item列是调换了的
data = X;
net_rating = spconvert(data(:,[1 2 3])); 
net = spones(net_rating);

%% PNR模型算法参数
pH = 0.1;       % 测试集占比
winSize = 7;    % PNR滤波窗口大小
bin = 80;        % 计算PNR的bin数目
topL = 40;      % topL推荐：对“每个用户”都推荐topL个item，有趣的现象：给他们推荐topL"大于"low_degree则会有明显效果
mu = 0;    % 正态分布均值
sigma = 1; % 正态分布方差
train_start_ratio = 0.0;
train_end_ratio = 0.5;
probe_start_ratio = 0.5;
probe_end_ratio = 0.6;
% low_degree = 50; % 与topL联系起来，low_degree增大PNR变优会影响整体性能
%% CF参数
K = 50;          % 计算user-item similarity的参数，对结果的影响也很大，K增大会使得PNR结果变优！！K太小则呈山峰爬升状而无效果
                 % wikibooks取35
%% basicMF参数
basicMF_lambda = 10;
basicMF_feat_num = 100;
basicMF_maxiter  = 20;
%% FISM参数
FISM_n_lfactors = 10;% ml-100k为96
FISM_alpha = 0.5; % ml-100k为0.4（如果程序出错，肯定是跟这里有关）
%% IBPR参数
IBPR_maxIter = 50;% 迭代次数，一般是25的整数倍
IBPR_d = 30; % U、V特征向量的维度数
%% SVDFeature参数  % 推荐效果很差有问题、很慢，不用
SVDFeature_maxiter = 10;
SVDFeature_k = 20;
%% MatricCompletion
MC_mu = 0.01;% mu = [0.001,0.01]
MC_rho = 5;% rho = [1,5]
MC_maxiter = 20;
%% PureSVD的参数
svd_k = 500;     % 计算PureSVD的参数,ml100k=300、200则有效
svd_maxit = 20;
%% NMF参数
nmf_k = 30;
nmf_maxit = 50;
%% PMF参数
PMF_maxepoch = 1; % ml1m是50
PMF_num_feat = 10;% ml1m是10
%% BPMF参数
BPMF_maxepoch = 20;% ml1m默认是50
BPMF_num_feat = 10;% ml1m默认是10

%% 时序网络划分数据集,0-1图
% [train, probe] = DivideNet(net, pH);
[train, probe] = timeDivideSeg(data, train_start_ratio, train_end_ratio, probe_start_ratio, probe_end_ratio);

deg_index = find(sum(train, 2) > 30); % 去掉user。在cosine_user下去掉小度用户后，效果好很多!!
train = train(deg_index,:);
probe = probe(deg_index,:);
net_rating = net_rating(deg_index,:);
deg_index = find(sum(train, 1) > 10); % 去掉item
train = train(:, deg_index);
probe = probe(:, deg_index);
net_rating = net_rating(:, deg_index);

train_rating = train .* net_rating;
probe_rating = probe .* net_rating;

%% 计算user-item的score，接着计算PNR
% MC\MF\FISM等方法可以通过train_rating与train分别测试看那个好
% sim = cosine_item_similarity(train);
% score = itemCF( train, sim, K);
% score = BPMF( train_rating, BPMF_maxepoch, BPMF_num_feat);
% score = PMF( train_rating, PMF_maxepoch, PMF_num_feat);% 跑wikibooks0.9 - 1.0出问题
% score = MatrixCompletion( train ,MC_mu, MC_rho, MC_maxiter);
% score = FISM( train, FISM_n_lfactors, FISM_alpha);
% score = (IBPR( train_rating, IBPR_maxIter, IBPR_d)); % recall与precision好像出问题，要注意使用！！
score = abs(  basicMF( train_rating, basicMF_lambda , basicMF_feat_num, basicMF_maxiter) );
% score = NMF( train, nmf_k, nmf_maxit);
% score = abs( PureSVD( train , svd_k, svd_maxit) ); % 加绝对值区别很大！！一定要加！！

result = hybridDistribution (score, train, bin, [0]); % 把score矩阵所有的0去掉（有时候不去掉0也会有更好的效果）
alpha =  nnz(probe)/ ( size(train, 1) * size(train, 2) - nnz(train) ); % 常数，使得PNR纵坐标的值没那么大
pnr =    PNR(result(:,5), result(:,6), result(:,1) , alpha);

%% 对PNR进行滤波
y = pnr(:,2)';
pnrGau =  [pnr(:,1),  smoothts(y,'g',winSize)']; % 高斯滤波，线性。
pnrMed =  [pnr(:,1),  medfilt1(y,    winSize)'];    % 中值滤波，非线性。
pnrMean = [pnr(:,1),  meanFilter(y,  winSize)'];  % 均值滤波，线性。
pnrExp =  [pnr(:,1),  smoothts(y,'e',winSize)']; % 指数法滤波。

%% 修改分数
% scorePNR = readjustScore (score, pnr);
% scoreGau = readjustScore (score, pnrGau);
% scoreMed = readjustScore (score, pnrMed);
% scoreMean = readjustScore(score, pnrMean);
% scoreExp = readjustScore (score, pnrExp);
scorePNR = readjustScoreUnique (score, pnr,     mu, sigma);% wikibooks数据集bin1/2/3变为0会有超级结果
scoreGau = readjustScoreUnique (score, pnrGau,  mu, sigma);
scoreMed = readjustScoreUnique (score, pnrMed,  mu, sigma);
scoreMean = readjustScoreUnique(score, pnrMean, mu, sigma);
scoreExp = readjustScoreUnique (score, pnrExp,  mu, sigma);

%% “分类准确度”评估指标：准确率（precision）、召回率(recall)（F-Measure，ep(L)，er(L)评估指标都是基于这两者）
[p, r] =         precision_recall( train ,probe, score,    topL);
[pPNR, rPNR] =   precision_recall( train ,probe, scorePNR, topL);
[pGau, rGau] =   precision_recall( train ,probe, scoreGau, topL);
[pMed, rMed] =   precision_recall( train ,probe, scoreMed, topL);
[pMean, rMean] = precision_recall( train ,probe, scoreMean,topL);
[pExp, rExp] =   precision_recall( train ,probe, scoreExp, topL);
plotPNR(pnr(:,1), [pnr(:,2),pnrGau(:,2),pnrMed(:,2),pnrMean(:,2),pnrExp(:,2)]);

%% “分类准确度”评估指标：AUC  (不知道为啥这里有错误)
% aucPNR = CalcAUC(train, probe, scorePNR);
% aucGau = CalcAUC(train, probe, scoreGau);
% aucMed = CalcAUC(train, probe, scoreMed);
% aucMean = CalcAUC(train, probe, scoreMean);
% aucExp = CalcAUC(train, probe, scoreExp);
% auc = CalcAUC(train, probe, score);

%% “排序准确度”：平均排序分（average ranking score），小
RS =      rankingScore( train, probe, score);
RS_PNR =  rankingScore( train, probe, scorePNR);
RS_Mean = rankingScore( train, probe, scoreMean);
RS_Exp =  rankingScore( train, probe, scoreExp);
RS_Gau =  rankingScore( train, probe, scoreGau);
RS_Med =  rankingScore( train, probe, scoreMed);

t2=clock();
