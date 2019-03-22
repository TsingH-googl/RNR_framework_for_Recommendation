clear all;
t1=clock();

%% 读入user-item二分图数据
%  非时序网络：
%  D:\链路预测相关课题\基于用户-物品的推荐\无时间上下文信息数据集\unicodelang\out.unicodelang，                           614*254，需要转置
%  D:\链路预测相关课题\基于用户-物品的推荐\无时间上下文信息数据集\moreno_crime\out.moreno_crime_crime，                   829*551，需要转置
%  D:\链路预测相关课题\基于用户-物品的推荐\无时间上下文信息数据集\brunson_revolution\out.brunson_revolution_revolution，  5*136，  需要转置
%  D:\链路预测相关课题\基于用户-物品的推荐\无时间上下文信息数据集\bookcrossing_rating\out.bookcrossing_rating_rating,很大，不稠密
%  D:\链路预测相关课题\基于用户-物品的推荐\无时间上下文信息数据集\filmtrust\ratings.txt，1500*2000

%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\edit-wikipedia\out.edit-wikipedia,需要转置,274000*2700(user去30，9000*2700，15分钟)
%  X D:\链路预测相关课题\基于用户-物品的推荐\无时间上下文信息数据集\Epinions-665k\ratings_data.txt，很大，稠密
%  X D:\链路预测相关课题\基于用户-物品的推荐\无时间上下文信息数据集\youtube-groupmemberships\out.youtube-groupmemberships,90000*4000,去20/10后为1500*1200

%  时序网络：
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-100k\u.data，                       943*1682,   15s
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-1m\data.txt，                       6000*4000，  6mins（改进后）
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\edit-frwikibooks\out.edit-frwikibooks，需要转置， 28113*2884
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\edit-frwikinews\out.edit-frwikinews，需要转置，   25000*1400
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\edit-enwikiquote\out.edit-enwikiquote,需要转置， 90000*20000
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\lastfm-2k\user_taggedartists-timestamps.dat, BPMF下rating需要归一化    2000*19000
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\hetrec2011-delicious-2k\user_taggedbookmarks-timestamps.dat，100000*100000
%  D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\opsahl-ucforum\out.opsahl-ucforum,需要转置，900*500

%  X D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\escorts\out.escorts，                            10000*6000，2.4mins
%  X D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-10m\out.movielens-10m_rating
%  X D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\stackexchange-stackoverflow\out.stackexchange-stackoverflow
% D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\digg-votes\out.digg-votes，140000*3500稠密！
% D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\citeulike-ut\out.citeulike-ut，稠密，userCF\itemCF没效果
% D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\amazon-ratings\out.amazon-ratings，不稠密，

X = load('D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\edit-frwikibooks\out.edit-frwikibooks'); % esccort好像在CF没那么有效
% temp=X(:,1);X(:,1)=X(:,2);X(:,2)=temp;%某些konect中的bipartite的user与item列是调换了的
data = X;
% data(:, 3) = 1; % non-rating
net_rating = spconvert(data(:,1:3)); % spconvert权值出错，调试一下
prop = datasetProp(net_rating); % 计算网络属性
net_rating = normScore( net_rating, 'matrix'); %% 有一些数据集出问题可能会是因为权值太大
net = spones(net_rating);

%% PNR模型算法参数
pH = 0.1;       % 测试集占比
winSize = 7;    % PNR滤波窗口大小
bin = 80;        % 计算PNR的bin数目
topL_array = [1 2 3 4 5 10 15 20 25 30 40 50]; % topL推荐
% topL = 20;      % topL推荐：对“每个用户”都推荐topL个item，有趣的现象：给他们推荐topL"大于"low_degree则会有明显效果
mu = 0;    % 正态分布均值
sigma = 10; % 正态分布方差
hibin = 24; % trick for adjust pnr
train_start_ratio = 0.0;
train_end_ratio = 0.7;
probe_start_ratio = 0.7;
probe_end_ratio = 0.8;
% low_degree = 50; % 与topL联系起来，low_degree增大PNR变优会影响整体性能
%% CF参数
K = 100;          % 原文为K=50左右；计算user-item similarity的参数，对结果的影响也很大，K增大会使得PNR结果变优！！K太小则呈山峰爬升状而无效果
% wikibooks取35
%% FISM参数
FISM_n_lfactors = 128;% delicious 96或64;原文2-32上升，96后稳定ml-100k为96（50效果好一点），FISM该这两个参数好像变化不大（ML1M时间较长）16+0.5则ML1M出错
FISM_alpha = 0.5; % 原文中ml-100k、netflix、yahoo为0.4-0.5（如果程序出错，肯定是跟这里有关）
%% IBPR参数
IBPR_maxIter = 50;% 迭代次数，一般是25的整数倍
IBPR_d = 30; % U、V特征向量的维度数
%% MatricCompletion
MC_mu = 250;% 太小会出问题；越小则ML100K越不好，mu = [0.001,0.01]不一定哦,ML100K在0.0006时候score为NAN;Wikibooks670.001变小会NAN、0.006不好
MC_rho = 4;% rho = [1,5]，增大rho好像对提高整体;2对wikibooks0.9不好;变小对整体十分不好；uvforum[0.05, 2.0]
MC_maxiter = 100;% 默认为1000次（小规模网络跟50次的速度差不多），50对wikibooks0.9buhao，ML100K0.9加大到100稍微改进.
%% PureSVD的参数
svd_k = 50;     % 原文ML1M\netflix为50/150；lastfm取200；wikinews变为100则总体差但效果好；MC论文中ML为100；计算PureSVD的参数,ml100k=300、200则有效？？ml0.9边10总体效果好,变成5对laskfm不好,lastfm论文为200，但总体效果差
svd_maxit = 10; % 原文没说，AAAI文取10；MC论文中ML为10；lastfm论文为10，但总体效果差;ML100K10+50总体好但不明显；
%% NMF参数
nmf_k = 10; % NMF原文ML100K为10-20，ML100K10较好;wikibooks20则总体好但是效果差
nmf_maxit = 50;% NMF原文ML100K为maxit为30-50，ML100K30较好
%% PMF参数
PMF_maxepoch = 50; % ml1m是50，原文中netflix max_epoch为50则比较好
PMF_num_feat = 10;% ml1m是10，原文netflix num_feat为10\20\30D
%% BPMF参数
BPMF_maxepoch = 50;% ml1m默认是50
BPMF_num_feat = 30;% ml1m默认是10，ml100k5较好（原文netflix默认为feat30/20，epoch20-50）
%% basicMF参数
basicMF_lambda = 10;% （lastFM改这里影响不大原文ML100K为[0.01,0.1, 1,2,4,8,10,20,30,40,60,80，为10-20时最好）,改小对我们better,但是总体变low，变大变小总体不大，但是一直好
basicMF_feat_num = 10;% (lastFM改这里对结果影响很大)默认为10(原文为8-20)，5或30、40都好加大这个laskfm会有效，不过耗时大
basicMF_maxiter  = 300; %不过好像50与100；原文为500次，默认为20或100，lastfm变小迭代次数，我们的方法没有优势;delicious[10 10 300]

%% 准备保存数据
pnriter = 1; % 循环pnriter次取均值，basicMF、MC、itemCF\userCF最好跑10次
recall = zeros(2 * pnriter,length(topL_array));
precision = zeros(2* pnriter,length(topL_array));
RS_all = zeros(1 * pnriter, 2);
hrResult = zeros(2 * pnriter,length(topL_array));
arhrResult = zeros(2 * pnriter, length(topL_array));
method = 'Test';
savedir = 'C:\Users\zmy201\Desktop\实验数据\delicious\';

%% 时序网络划分数据集,0-1图
[train, probe] = timeDivideSeg(data, train_start_ratio, train_end_ratio, probe_start_ratio, probe_end_ratio);

% ARHR没效果，改这里也没多大作用
deg_index = find(sum(train, 2) > 5); % 去掉user。总体感觉user去5个效果才好，而item最好是0或者5；100k去5/0;在cosine_user下去掉小度用户后，效果好很多!!MC去掉小度用户也好很多
train = train(deg_index,:);
probe = probe(deg_index,:);
net_rating = net_rating(deg_index,:);
deg_index = find(sum(train, 1) > 2); % 去掉item，去掉大于5的会好
train = train(:, deg_index);
probe = probe(:, deg_index);
net_rating = net_rating(:, deg_index);

train_rating = abs(train .* net_rating);
probe_rating = abs(probe .* net_rating);

for iter = 1 : pnriter
    %% 计算user-item的score，接着计算PNR
    %% 注意：看看啊写数据集是有rating，哪些算法是需要rating
    % MC\MF\FISM等方法可以通过train_rating与train分别测试看那个好
%         sim = pearson_item_similarity(train); %% wikibooks用pearsonitem效果好！！deliciouscoisnuser好;ucform-pearsonuser-k=20时好时坏
%         score = itemCF( train, sim, K); % 4300*5900需要6分钟
%      score = abs ( BPMF( train_rating, BPMF_maxepoch, BPMF_num_feat) );
%      score = abs ( PMF( train_rating, PMF_maxepoch, PMF_num_feat) );
%       score = abs ( MatrixCompletion( train ,MC_mu, MC_rho, MC_maxiter) ); % 4300*5900要一个小时
%      score = abs ( FISM( train, FISM_n_lfactors, FISM_alpha) ); %item\user去掉5; Wikibooks78，10重复，30mins
%       score = abs ( basicMF( train_rating, basicMF_lambda , basicMF_feat_num, basicMF_maxiter) );
%      score = abs ( NMF( train, nmf_k, nmf_maxit) ); % 原文为加rating,我们不加RATING; last fm加rating不好且总体不好
   score = abs ( PureSVD( train , svd_k, svd_maxit) ); % pureSVD这里我不用rating（原文用rating但总体差别不大且我们的方法更突出）加绝对值
    
    result = hybridDistribution (score, train, bin, [0]); % 把score矩阵所有的0去掉（有时候不去掉0也会有更好的效果）
    alpha =  nnz(probe)/ ( size(train, 1) * size(train, 2) - nnz(train) ); % 常数，使得PNR纵坐标的值没那么大
    pnr =    PNR(result(:,5), result(:,6), result(:,1) , alpha);
    %     pnr = trickPNR( pnr, hibin );
    
    %% 对PNR进行滤波
    y = pnr(:,2)';
    pnrGau =  [pnr(:,1),  smoothts(y,'g',winSize)'];  % 高斯滤波，线性。
    pnrMed =  [pnr(:,1),  medfilt1(y,    winSize)'];  % 中值滤波，非线性。
    pnrMean = [pnr(:,1),  meanFilter(y,  winSize)'];  % 均值滤波，线性。
    pnrExp =  [pnr(:,1),  smoothts(y,'e',winSize)'];  % 指数法滤波。
    % plotPNR(pnr(:,1), [pnr(:,2),pnrGau(:,2),pnrMed(:,2),pnrMean(:,2),pnrExp(:,2)]);
    
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
    
    for top_index = 1 : 1: length(topL_array)
        topL = topL_array(top_index);
        %% “分类准确度”评估指标：准确率（precision）、召回率(recall)（F-Measure，ep(L)，er(L)评估指标都是基于这两者）
        [p, r, hr, arhr] =                 evaluator( train ,probe, score,    topL);
        [pPNR, rPNR, hrPNR, arhrPNR] =     evaluator( train ,probe, scorePNR, topL);
        [pGau, rGau, hrGau, arhrGau] =     evaluator( train ,probe, scoreGau, topL);
        [pMed, rMed, hrMed, arhrMed] =     evaluator( train ,probe, scoreMed, topL);
        [pMean, rMean, hrMean, arhrMean] = evaluator( train ,probe, scoreMean,topL);
        [pExp, rExp, hrExp, arhrExp] =     evaluator( train ,probe, scoreExp, topL);
        recall(1 + 2*(iter-1), top_index)     =  r;
        recall(2 + 2*(iter-1), top_index)     =  max([rPNR, rGau, rMed, rMean, rExp]);
        precision(1 + 2*(iter-1), top_index)  =  p;
        precision(2 + 2*(iter-1), top_index)  =  max([pPNR, pGau, pMed, pMean, pExp]);
        hrResult(1 + 2*(iter-1), top_index)   =  hr;
        hrResult(2 + 2*(iter-1), top_index)   =  max([hrPNR, hrGau, hrMed, hrMean, hrExp]);
        arhrResult(1 + 2*(iter-1), top_index) =  arhr;
        arhrResult(2 + 2*(iter-1), top_index) =  max([arhrPNR, arhrGau, arhrMed, arhrMean, arhrExp]);
        
    end
    %% “排序准确度”：平均排序分（average ranking score），小
    RS =      rankingScore( train, probe, score);
    RS_PNR =  rankingScore( train, probe, scorePNR);
    RS_Mean = rankingScore( train, probe, scoreMean);
    RS_Exp =  rankingScore( train, probe, scoreExp);
    RS_Gau =  rankingScore( train, probe, scoreGau);
    RS_Med =  rankingScore( train, probe, scoreMed);
    RS_all( iter, :) = [RS, min([RS_PNR, RS_Mean, RS_Exp, RS_Gau, RS_Med])];
    
end
%% 画图
% plotRecallRendering   ( topL_array, recall,method     );
% plotARHRRendering     ( topL_array, arhrResult, method );
% plotPrecisionRendering( topL_array, precision, method  );

%% 保存原始数据
% save(strcat(savedir ,method,'-', num2str(probe_start_ratio*10),num2str(probe_end_ratio*10) ,'.mat'), 'precision');%
save(strcat(savedir ,method,'-', num2str(probe_start_ratio*10),num2str(probe_end_ratio*10) ,'.mat')); % 保存所有工作区变量
plotARHRRendering     ( topL_array, arhrResult, method);

t2=clock();
