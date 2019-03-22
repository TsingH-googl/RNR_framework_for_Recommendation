%% 程序正确，效率高
function sim = jaccard_item_similarity( train);
train = spones(train);
[userNum, itemNum] = size(train);
Wij_n = train' * train;
Wij_d = sparse(itemNum, itemNum);
deg_row = (repmat(sum(train,1), [size(train,2),1])); % 计算每个节点的度
deg_row = deg_row .* spones(Wij_n); % 只保留分子不为0的对应的元素，因为有交集的节点我们才计算它们的JB
deg_row = triu(deg_row) + triu(deg_row');
Wij_d = deg_row.*spones(Wij_n)-Wij_n;
sim = triu(Wij_n ./ Wij_d);
sim = sim + sim';
sim = sim -diag(diag(sim));
sim(isnan(sim)) = 0; 
sim(isinf(sim)) = 0;
end

