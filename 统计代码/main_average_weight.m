clear all;
t1=clock();

%% ����user-item����ͼ����

%  ʱ�����磺
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u.data��                       943*1682,   15s
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-1m\data.txt��                       6000*4000��  6mins���Ľ���
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-frwikibooks\out.edit-frwikibooks����Ҫת�ã� 28113*2884
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-frwikinews\out.edit-frwikinews����Ҫת�ã�   25000*1400
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\edit-enwikiquote\out.edit-enwikiquote,��Ҫת�ã� 90000*20000
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\lastfm-2k\user_taggedartists-timestamps.dat, BPMF��rating��Ҫ��һ��    2000*19000
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\hetrec2011-delicious-2k\user_taggedbookmarks-timestamps.dat��100000*100000
%  D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\opsahl-ucforum\out.opsahl-ucforum,��Ҫת�ã�900*500

X = load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u.data'); % esccort������CFû��ô��Ч
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
mu = 0;    % ��̬�ֲ���ֵ
sigma = 10; % ��̬�ֲ�����
hibin = 24; % trick for adjust pnr
train_start_ratio = 0.0;
train_end_ratio = 0.9;
probe_start_ratio = 0.9;
probe_end_ratio = 1.0;
% low_degree = 50; % ��topL��ϵ������low_degree����PNR���Ż�Ӱ����������
%% CF����
K = 25;          % ԭ��ΪK=50���ң�����user-item similarity�Ĳ������Խ����Ӱ��Ҳ�ܴ�K�����ʹ��PNR������ţ���K̫С���ɽ������״����Ч��
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
pnriter = 10; % ѭ��pnriter��ȡ��ֵ��basicMF��MC��itemCF\userCF�����10��
method = 'ItemKNN-jaccard';
savedir = 'C:\Users\zmy201\Desktop\ʵ������\AVE_WEIGHT\ML100K\910\';

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
        sim = jaccard_item_similarity(train); %% wikibooks��pearsonitemЧ���ã���deliciouscoisnuser��;ucform-pearsonuser-k=20ʱ��ʱ��
        score = itemCF( train, sim, K); % 4300*5900��Ҫ6����
%      score = abs ( BPMF( train_rating, BPMF_maxepoch, BPMF_num_feat) );
%      score = abs ( PMF( train_rating, PMF_maxepoch, PMF_num_feat) );
%       score = abs ( MatrixCompletion( train ,MC_mu, MC_rho, MC_maxiter) ); % 4300*5900Ҫһ��Сʱ
%      score = abs ( FISM( train, FISM_n_lfactors, FISM_alpha) ); %item\userȥ��5; Wikibooks78��10�ظ���30mins
%       score = abs ( basicMF( train_rating, basicMF_lambda , basicMF_feat_num, basicMF_maxiter) );
%      score = abs ( NMF( train, nmf_k, nmf_maxit) ); % ԭ��Ϊ��rating,���ǲ���RATING; last fm��rating���������岻��
%    score = abs ( PureSVD( train , svd_k, svd_maxit) ); % pureSVD�����Ҳ���rating��ԭ����rating�������𲻴������ǵķ�����ͻ�����Ӿ���ֵ
    
    result = hybridDistribution (score, train, bin, [0]); % ��score�������е�0ȥ������ʱ��ȥ��0Ҳ���и��õ�Ч����
    alpha =  nnz(probe)/ ( size(train, 1) * size(train, 2) - nnz(train) ); % ������ʹ��PNR�������ֵû��ô��
    pnr =    PNR(result(:,5), result(:,6), result(:,1) , alpha);
    
    %% ��PNR�����˲�
    y = pnr(:,2)';
%     pnrGau =  [pnr(:,1),  smoothts(y,'g',winSize)'];  % ��˹�˲������ԡ�
%     pnrMed =  [pnr(:,1),  medfilt1(y,    winSize)'];  % ��ֵ�˲��������ԡ�
%     pnrMean = [pnr(:,1),  meanFilter(y,  winSize)'];  % ��ֵ�˲������ԡ�
%     pnrExp =  [pnr(:,1),  smoothts(y,'e',winSize)'];  % ָ�����˲���
    
    %% �޸ķ���
    scorePNR = readjustScoreUnique (score, pnr,     mu, sigma);% wikibooks���ݼ�bin1/2/3��Ϊ0���г������
%     scoreGau = readjustScoreUnique (score, pnrGau,  mu, sigma);
%     scoreMed = readjustScoreUnique (score, pnrMed,  mu, sigma);
%     scoreMean = readjustScoreUnique(score, pnrMean, mu, sigma);
%     scoreExp = readjustScoreUnique (score, pnrExp,  mu, sigma);
    
    save(strcat(savedir ,method,'-', num2str(probe_start_ratio*10),num2str(probe_end_ratio*10) ,'--',num2str(iter),'.mat'), 'scorePNR');%
    
end

t2=clock();
