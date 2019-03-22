%% 程序正确，效率十分高
function sim = jaccard_user_similarity( train)
train = spones(train);
[userNum, itemNum] = size(train);
Wuv_n = train * train';
Wuv_d = sparse(userNum, userNum);
deg_row = (repmat(sum(train,2), [1, size(train,1)]))'; % 计算每个节点的度
deg_row = deg_row .* spones(Wuv_n); % 只保留分子不为0的对应的元素，因为有交集的节点我们才计算它们的JB
deg_row = triu(deg_row) + triu(deg_row');
Wuv_d = deg_row.*spones(Wuv_n)-Wuv_n;
sim = triu(Wuv_n ./ Wuv_d);
sim = sim + sim';
sim = sim -diag(diag(sim));
sim(isnan(sim)) = 0; 
sim(isinf(sim)) = 0;

end