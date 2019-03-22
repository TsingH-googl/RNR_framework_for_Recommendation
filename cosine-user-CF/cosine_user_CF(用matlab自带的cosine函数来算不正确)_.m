clear all;
t1= clock;
%% 读取训练集与测试集数据
data = (load('D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-100k\u.data'));
train = (load('D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-100k\u5.base'));
test = (load('D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-100k\u5.test'));% 不知道为什么，这里的test在第460多位用户之后没有相关数据！
train = sortrows(train , 4);
test = sortrows(test , 4);
train(:,5) = formatdate(train(:,4)); % 时间数据按照天来算
test(:,5) = formatdate(test(:,4)); % 时间数据按照天来算

%% 根据训练集，基于pearson距离生成user-similarity
userNum = max(data(:,1));
itemNum = max(data(:,2));
ratingTrain = sparse(userNum ,itemNum);
ratingTrain(  sub2ind(size(ratingTrain)  , train(:,1),train(:,2))) = train(:,3);
D = pdist(~~ratingTrain, 'cosine');
sim = squareform(D);
% ratingTrain = spconvert(train(:,1:3));
% [usersim p ] = corrcoef(full(ratingTrain')); % 其中，p(i,j)指的是sim(i,j)相关系数值为0的置信概率，1-p(i,j)指的是sim(i,j)相关系数值为r(i,j)的置信概率
% [i j] = find(p<0.05);% 置信为0.05，注意,finda函数返回的是行、列坐标值
% temp(:,1) = i;temp(:,2) = j;
% temp(:,3) = usersim(sub2ind(size(usersim),i,j));
% sim = spconvert(temp);

%% 根据user-similarity计算每个用户对所有item的probability，保存在score稀疏矩阵
%% 注意，这里既要计算买过的item也要算没有买过的item，因为后面要计算existing 与nonexisting的分数分布
[sA index] = sort(sim, 2 ,'descend'); % 对user相似性矩阵sim_flash按行降序排序
K = 10; % 选择前K个与当前用户最相似的前K个用户
% 计算第u个用户对所有item的probability, p(u, i)
score = sparse(userNum, itemNum);
for u = 1:1:userNum
    for i = 1:1:itemNum
        s_uk = index(u,1:K); % 跟用户u相似的前K个用户的索引值
        [N_i_index j] = find(ratingTrain(:,i)>0); % 购买item i的所有用户的索引值
        v_intersect = (intersect(s_uk, N_i_index)); % 根据p(u,i)公式，计算交集v且防止重复v
        p_ui = sum( sim(u,v_intersect) );
        score(u,i) = full(p_ui);
    end
end

%% 根据score矩阵，对每个user进行推荐item。
%% 并且计算准确率，召回率，覆盖率，流行度。
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
[val index] = sort(score_nonexisting,2, 'descend');
% 找出推荐准确的item，并且统计其总数目
sum_correct = 0; % 注意：sum变量不能和sum函数一起使用，否则出现“下标索引必须为正整数类型或逻辑类型”错误
for u = 1:1:userNum  % 不需要遍历所有的用户，因为有些用户在test中没有数据
    u_actual = ratingTest_norm(u,:);
    u_topN = sum(u_actual);
    [i j] = find(ratingTest_norm(u,:)>0);% 保存第u个用户实际买的东西的索引，注意，索引在列j中
    u_correct = length((intersect(index(u,1:u_topN),j)));
    sum_correct = sum_correct + u_correct;
end

precision = sum_correct / length(test); % u1:10.67%, u2;  , u3: , u4:5.61%  , u5: 6.52%（不考虑评分标准化为1，为6.44%）。
    
t2= clock;
etime(t2,t1);





