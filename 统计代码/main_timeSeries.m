clear all;
t1=clock();

%% ����user-item����ͼ����
%  ��ʱ�����磺
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\unicodelang\out.unicodelang��                           614*254����Ҫת��
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\moreno_crime\out.moreno_crime_crime��                   829*551����Ҫת��
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\brunson_revolution\out.brunson_revolution_revolution��  5*136��  ��Ҫת��
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\bookcrossing_rating\out.bookcrossing_rating_rating,�ܴ󣬲�����
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\filmtrust\ratings.txt��1500*2000

%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-wikipedia\out.edit-wikipedia,��Ҫת��,274000*2700(userȥ30��9000*2700��15����)
%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\Epinions-665k\ratings_data.txt���ܴ󣬳���
%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\��ʱ����������Ϣ���ݼ�\youtube-groupmemberships\out.youtube-groupmemberships,90000*4000,ȥ20/10��Ϊ1500*1200

%  ʱ�����磺
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u.data��                       943*1682,   15s
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-1m\data.txt��                       6000*4000��  6mins���Ľ���
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-frwikibooks\out.edit-frwikibooks����Ҫת�ã� 28113*2884
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-frwikinews\out.edit-frwikinews����Ҫת�ã�   25000*1400
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-enwikiquote\out.edit-enwikiquote,��Ҫת�ã� 90000*20000
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\lastfm-2k\user_taggedartists-timestamps.dat, BPMF��rating��Ҫ��һ��    2000*19000
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\hetrec2011-delicious-2k\user_taggedbookmarks-timestamps.dat��100000*100000
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\opsahl-ucforum\out.opsahl-ucforum,��Ҫת�ã�900*500

%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\escorts\out.escorts��                            10000*6000��2.4mins
%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-10m\out.movielens-10m_rating
%  X D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\stackexchange-stackoverflow\out.stackexchange-stackoverflow
% D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\digg-votes\out.digg-votes��140000*3500���ܣ�
% D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\citeulike-ut\out.citeulike-ut�����ܣ�userCF\itemCFûЧ��
% D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\amazon-ratings\out.amazon-ratings�������ܣ�

X = load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-frwikibooks\out.edit-frwikibooks'); % esccort������CFû��ô��Ч
% temp=X(:,1);X(:,1)=X(:,2);X(:,2)=temp;%ĳЩkonect�е�bipartite��user��item���ǵ����˵�
data = X;
% data(:, 3) = 1; % non-rating
net_rating = spconvert(data(:,1:3)); % spconvertȨֵ��������һ��
prop = datasetProp(net_rating); % ������������
net_rating = normScore( net_rating, 'matrix'); %% ��һЩ���ݼ���������ܻ�����ΪȨֵ̫��
net = spones(net_rating);

%% PNRģ���㷨����
pH = 0.1;       % ���Լ�ռ��
winSize = 7;    % PNR�˲����ڴ�С
bin = 80;        % ����PNR��bin��Ŀ
topL_array = [1 2 3 4 5 10 15 20 25 30 40 50]; % topL�Ƽ�
% topL = 20;      % topL�Ƽ����ԡ�ÿ���û������Ƽ�topL��item����Ȥ�����󣺸������Ƽ�topL"����"low_degree���������Ч��
mu = 0;    % ��̬�ֲ���ֵ
sigma = 10; % ��̬�ֲ�����
hibin = 24; % trick for adjust pnr
train_start_ratio = 0.0;
train_end_ratio = 0.7;
probe_start_ratio = 0.7;
probe_end_ratio = 0.8;
% low_degree = 50; % ��topL��ϵ������low_degree����PNR���Ż�Ӱ����������
%% CF����
K = 100;          % ԭ��ΪK=50���ң�����user-item similarity�Ĳ������Խ����Ӱ��Ҳ�ܴ�K�����ʹ��PNR������ţ���K̫С���ɽ������״����Ч��
% wikibooksȡ35
%% FISM����
FISM_n_lfactors = 128;% delicious 96��64;ԭ��2-32������96���ȶ�ml-100kΪ96��50Ч����һ�㣩��FISM����������������仯����ML1Mʱ��ϳ���16+0.5��ML1M����
FISM_alpha = 0.5; % ԭ����ml-100k��netflix��yahooΪ0.4-0.5�������������϶��Ǹ������йأ�
%% IBPR����
IBPR_maxIter = 50;% ����������һ����25��������
IBPR_d = 30; % U��V����������ά����
%% MatricCompletion
MC_mu = 250;% ̫С������⣻ԽС��ML100KԽ���ã�mu = [0.001,0.01]��һ��Ŷ,ML100K��0.0006ʱ��scoreΪNAN;Wikibooks670.001��С��NAN��0.006����
MC_rho = 4;% rho = [1,5]������rho������������;2��wikibooks0.9����;��С������ʮ�ֲ��ã�uvforum[0.05, 2.0]
MC_maxiter = 100;% Ĭ��Ϊ1000�Σ�С��ģ�����50�ε��ٶȲ�ࣩ��50��wikibooks0.9buhao��ML100K0.9�Ӵ�100��΢�Ľ�.
%% PureSVD�Ĳ���
svd_k = 50;     % ԭ��ML1M\netflixΪ50/150��lastfmȡ200��wikinews��Ϊ100������Ч���ã�MC������MLΪ100������PureSVD�Ĳ���,ml100k=300��200����Ч����ml0.9��10����Ч����,���5��laskfm����,lastfm����Ϊ200��������Ч����
svd_maxit = 10; % ԭ��û˵��AAAI��ȡ10��MC������MLΪ10��lastfm����Ϊ10��������Ч����;ML100K10+50����õ������ԣ�
%% NMF����
nmf_k = 10; % NMFԭ��ML100KΪ10-20��ML100K10�Ϻ�;wikibooks20������õ���Ч����
nmf_maxit = 50;% NMFԭ��ML100KΪmaxitΪ30-50��ML100K30�Ϻ�
%% PMF����
PMF_maxepoch = 50; % ml1m��50��ԭ����netflix max_epochΪ50��ȽϺ�
PMF_num_feat = 10;% ml1m��10��ԭ��netflix num_featΪ10\20\30D
%% BPMF����
BPMF_maxepoch = 50;% ml1mĬ����50
BPMF_num_feat = 30;% ml1mĬ����10��ml100k5�Ϻã�ԭ��netflixĬ��Ϊfeat30/20��epoch20-50��
%% basicMF����
basicMF_lambda = 10;% ��lastFM������Ӱ�첻��ԭ��ML100KΪ[0.01,0.1, 1,2,4,8,10,20,30,40,60,80��Ϊ10-20ʱ��ã�,��С������better,���������low������С���岻�󣬵���һֱ��
basicMF_feat_num = 10;% (lastFM������Խ��Ӱ��ܴ�)Ĭ��Ϊ10(ԭ��Ϊ8-20)��5��30��40���üӴ����laskfm����Ч��������ʱ��
basicMF_maxiter  = 300; %��������50��100��ԭ��Ϊ500�Σ�Ĭ��Ϊ20��100��lastfm��С�������������ǵķ���û������;delicious[10 10 300]

%% ׼����������
pnriter = 1; % ѭ��pnriter��ȡ��ֵ��basicMF��MC��itemCF\userCF�����10��
recall = zeros(2 * pnriter,length(topL_array));
precision = zeros(2* pnriter,length(topL_array));
RS_all = zeros(1 * pnriter, 2);
hrResult = zeros(2 * pnriter,length(topL_array));
arhrResult = zeros(2 * pnriter, length(topL_array));
method = 'Test';
savedir = 'C:\Users\zmy201\Desktop\ʵ������\delicious\';

%% ʱ�����绮�����ݼ�,0-1ͼ
[train, probe] = timeDivideSeg(data, train_start_ratio, train_end_ratio, probe_start_ratio, probe_end_ratio);

% ARHRûЧ����������Ҳû�������
deg_index = find(sum(train, 2) > 5); % ȥ��user������о�userȥ5��Ч���źã���item�����0����5��100kȥ5/0;��cosine_user��ȥ��С���û���Ч���úܶ�!!MCȥ��С���û�Ҳ�úܶ�
train = train(deg_index,:);
probe = probe(deg_index,:);
net_rating = net_rating(deg_index,:);
deg_index = find(sum(train, 1) > 2); % ȥ��item��ȥ������5�Ļ��
train = train(:, deg_index);
probe = probe(:, deg_index);
net_rating = net_rating(:, deg_index);

train_rating = abs(train .* net_rating);
probe_rating = abs(probe .* net_rating);

for iter = 1 : pnriter
    %% ����user-item��score�����ż���PNR
    %% ע�⣺������д���ݼ�����rating����Щ�㷨����Ҫrating
    % MC\MF\FISM�ȷ�������ͨ��train_rating��train�ֱ���Կ��Ǹ���
%         sim = pearson_item_similarity(train); %% wikibooks��pearsonitemЧ���ã���deliciouscoisnuser��;ucform-pearsonuser-k=20ʱ��ʱ��
%         score = itemCF( train, sim, K); % 4300*5900��Ҫ6����
%      score = abs ( BPMF( train_rating, BPMF_maxepoch, BPMF_num_feat) );
%      score = abs ( PMF( train_rating, PMF_maxepoch, PMF_num_feat) );
%       score = abs ( MatrixCompletion( train ,MC_mu, MC_rho, MC_maxiter) ); % 4300*5900Ҫһ��Сʱ
%      score = abs ( FISM( train, FISM_n_lfactors, FISM_alpha) ); %item\userȥ��5; Wikibooks78��10�ظ���30mins
%       score = abs ( basicMF( train_rating, basicMF_lambda , basicMF_feat_num, basicMF_maxiter) );
%      score = abs ( NMF( train, nmf_k, nmf_maxit) ); % ԭ��Ϊ��rating,���ǲ���RATING; last fm��rating���������岻��
   score = abs ( PureSVD( train , svd_k, svd_maxit) ); % pureSVD�����Ҳ���rating��ԭ����rating�������𲻴������ǵķ�����ͻ�����Ӿ���ֵ
    
    result = hybridDistribution (score, train, bin, [0]); % ��score�������е�0ȥ������ʱ��ȥ��0Ҳ���и��õ�Ч����
    alpha =  nnz(probe)/ ( size(train, 1) * size(train, 2) - nnz(train) ); % ������ʹ��PNR�������ֵû��ô��
    pnr =    PNR(result(:,5), result(:,6), result(:,1) , alpha);
    %     pnr = trickPNR( pnr, hibin );
    
    %% ��PNR�����˲�
    y = pnr(:,2)';
    pnrGau =  [pnr(:,1),  smoothts(y,'g',winSize)'];  % ��˹�˲������ԡ�
    pnrMed =  [pnr(:,1),  medfilt1(y,    winSize)'];  % ��ֵ�˲��������ԡ�
    pnrMean = [pnr(:,1),  meanFilter(y,  winSize)'];  % ��ֵ�˲������ԡ�
    pnrExp =  [pnr(:,1),  smoothts(y,'e',winSize)'];  % ָ�����˲���
    % plotPNR(pnr(:,1), [pnr(:,2),pnrGau(:,2),pnrMed(:,2),pnrMean(:,2),pnrExp(:,2)]);
    
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
        recall(1 + 2*(iter-1), top_index)     =  r;
        recall(2 + 2*(iter-1), top_index)     =  max([rPNR, rGau, rMed, rMean, rExp]);
        precision(1 + 2*(iter-1), top_index)  =  p;
        precision(2 + 2*(iter-1), top_index)  =  max([pPNR, pGau, pMed, pMean, pExp]);
        hrResult(1 + 2*(iter-1), top_index)   =  hr;
        hrResult(2 + 2*(iter-1), top_index)   =  max([hrPNR, hrGau, hrMed, hrMean, hrExp]);
        arhrResult(1 + 2*(iter-1), top_index) =  arhr;
        arhrResult(2 + 2*(iter-1), top_index) =  max([arhrPNR, arhrGau, arhrMed, arhrMean, arhrExp]);
        
    end
    %% ������׼ȷ�ȡ���ƽ������֣�average ranking score����С
    RS =      rankingScore( train, probe, score);
    RS_PNR =  rankingScore( train, probe, scorePNR);
    RS_Mean = rankingScore( train, probe, scoreMean);
    RS_Exp =  rankingScore( train, probe, scoreExp);
    RS_Gau =  rankingScore( train, probe, scoreGau);
    RS_Med =  rankingScore( train, probe, scoreMed);
    RS_all( iter, :) = [RS, min([RS_PNR, RS_Mean, RS_Exp, RS_Gau, RS_Med])];
    
end
%% ��ͼ
% plotRecallRendering   ( topL_array, recall,method     );
% plotARHRRendering     ( topL_array, arhrResult, method );
% plotPrecisionRendering( topL_array, precision, method  );

%% ����ԭʼ����
% save(strcat(savedir ,method,'-', num2str(probe_start_ratio*10),num2str(probe_end_ratio*10) ,'.mat'), 'precision');%
save(strcat(savedir ,method,'-', num2str(probe_start_ratio*10),num2str(probe_end_ratio*10) ,'.mat')); % �������й���������
plotARHRRendering     ( topL_array, arhrResult, method);

t2=clock();
