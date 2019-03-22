%% 经过了改进的itemCF，intersect与find等函数十分耗时，应该转化为“矩阵相乘”。代码正确，效率高
function score = itemCF( train, sim,  K)
[userNum, itemNum] = size(train);
KIndex = sparse(itemNum, itemNum);
[sA ,index] = sort(sim, 2 ,'descend'); % 对相似性矩阵按行降序排序，不改变sim，效率高
for i =1:1:itemNum
    KIndex(i,index(i,1:K)) = 1; % 保存每个item相似的前K个item的索引到KIndex矩阵
end
Ksim = KIndex .*  sim; % 计算每个item对当前相似的前K个item的相似性值sim(i, j)，后续再与train相乘
score = sparse(train * Ksim'); % 与train相乘，即是前K个相似item的sim值总和
end

































%% 
% function score = itemCF( ratingTrain, sim,  K)
% [userNum, itemNum] = size(ratingTrain);
% [sA ,index] = sort(sim, 2 ,'descend'); % 对item相似性矩阵sim按行降序排序
% % 计算第u个用户对所有item的probability, p(u, j)
% score = sparse(userNum, itemNum);
% for u = 1:1:userNum
%     for j = 1:1:itemNum
%         s_jk = index(j,1:K); % 跟物品j相似的前K个item的索引值
%         [i ,N_u_index] = find(ratingTrain(u,:)>0); % 用户u购买所有物品N(u)
%         i_intersect = intersect(s_jk, N_u_index); % 根据p(u,j)公式，计算交集i且防止重复i
%         p_uj = sum( sim(j,i_intersect) );
%         score(u,j) = full(p_uj); 
%     end
% end
% 
% 
% end
