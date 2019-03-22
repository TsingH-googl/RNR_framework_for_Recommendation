%% 经过了改进的userCF，intersect与find、sub2ind等函数十分耗时，应该转化为“矩阵相乘”。代码正确，效率高
function score = userCF( train, sim, K)
[userNum, itemNum] = size(train);
KIndex = sparse(userNum, userNum);
[sA ,index] = sort(sim, 2 ,'descend'); % 对相似性矩阵按行降序排序，不改变sim，效率高
for u =1:1:userNum
    KIndex(u,index(u,1:K)) = 1; % 保存每个用户相似的前K个用户的索引到KIndex矩阵
end
Ksim = KIndex .* sim; % 计算每个用户对当前相似的前K个用户的相似性值sim(u, v)，后续再与train相乘
score = sparse(Ksim * train); % 与train相乘，即是前K个相似用户喜欢item的sim值总和
end