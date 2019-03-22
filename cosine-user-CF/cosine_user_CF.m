clear all;
t1= clock;
%% 读取训练集与测试集数据
data = (load('D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-100k\u.data'));
train = (load('D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-100k\u1.base'));
test = (load('D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-100k\u1.test'));% 不知道为什么，这里的test在第460多位用户之后没有相关数据！
train = sortrows(train , 4);
test = sortrows(test , 4);
train(:,5) = formatdate(train(:,4)); % 时间数据按照天来算
test(:,5) = formatdate(test(:,4)); % 时间数据按照天来算

%% 根据训练集，基于余弦相似度生成sim
userNum = max(data(:,1));
itemNum = max(data(:,2));
ratingTrain = sparse(userNum ,itemNum);
ratingTrain(  sub2ind(size(ratingTrain)  , train(:,1),train(:,2))) = train(:,3);
ratingTrain_norm = ~~ratingTrain;
sim = cosine_user_similarity( ratingTrain_norm);

%% 根据user-similarity计算每个用户对所有item的probability，保存在score稀疏矩阵
%% 注意，这里既要计算买过的item也要算没有买过的item，因为后面要计算existing 与nonexisting的分数分布
K = 10; % 选择前K个与当前用户最相似的前K个用户
score = userCF( ratingTrain, sim, userNum, itemNum, K);


%% 根据score矩阵，对每个user进行推荐item。
%% 并且计算准确率，召回率，覆盖率，流行度。
% 计算presicion
%  首先分离出买过东西的score_existing与没买过东西的score_nonexisting
score_existing = sparse(userNum, itemNum);
score_existing = sparse(~~ratingTrain)  .*  score;
score_nonexisting = sparse(userNum, itemNum);
score_nonexisting = sparse(~ratingTrain)  .*  score;
% 计算召回率recall，根据测试集中每个用户缺的数目进行推荐，即TopN推荐
ratingTest = sparse(userNum ,itemNum);
ratingTest(  sub2ind(size(ratingTest)  , test(:,1),test(:,2))) = test(:,3);
ratingTest_norm = ~~ratingTest;
score_nonexisting_norm = ~~score_nonexisting;
precision = precision( score_nonexisting,max(test(:,1)) ,ratingTest_norm);% 不需要遍历所有的用户，因为有些用户在test中没有数据

%                             pearson_user_CF : % u1:41.49%, u2; 36.59% , u3: , u4:33.73%  , u5:34.74% 。
                          % u1:41.28%, u2;  , u3: , u4:  , u5: 。
    
t2= clock;
etime(t2,t1);





