clear all;
%% 读取原始数据
data = (load('D:\链路预测相关课题\基于用户-物品的推荐\时间上下文信息数据集\MovieLens\ml-100k\u.data'));
data = sortrows(data , 4);
data(:,5) = formatdate(data(:,4)); % 时间数据按照天来算

%% 划分训练与测试数据集
pH =  0.2; % 测试集的大小
testLength = length(data)*pH;
trainLength = length(data) - testLength;
train = data(1:trainLength,:);
test = data(trainLength+1:length(data),:);

%% 根据训练集，基于pearson距离生成user-similarity
userNum = max(data(:,1));
itemNum = max(data(:,2));
ratingTrain = sparse(userNum ,itemNum);
ratingTrain(  sub2ind(size(ratingTrain)  , train(:,1),train(:,2))) = train(:,3);
% ratingTrain = spconvert(train(:,1:3));
[sim p ] = corrcoef(full(ratingTrain')); % 其中，p(i,j)指的是sim(i,j)相关系数值为0的置信概率，1-p(i,j)指的是sim(i,j)相关系数值为r(i,j)的置信概率
[i j] = find(p<0.05);% 置信为0.05
temp(:,1) = i;temp(:,2) = j;
temp(:,3) = sim(sub2ind(size(sim),i,j));
sim_flash = spconvert(temp);
% temp = sparse(userNum ,userNum);
% temp(  sub2ind(size(temp), i, j)) = 1;
% sim_flash = sparse(sim).*temp; % 去除置信值小于95%的相关系数

% clear temp;
% 发现问题：这样划分数据集不合理，因为不是所有用户在整个时间跨度是有买东西/打分的
%% 






