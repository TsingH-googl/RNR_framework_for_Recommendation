%% ������ȷ��Ч�ʸ�
function sim = jaccard_item_similarity( train);
train = spones(train);
[userNum, itemNum] = size(train);
Wij_n = train' * train;
Wij_d = sparse(itemNum, itemNum);
deg_row = (repmat(sum(train,1), [size(train,2),1])); % ����ÿ���ڵ�Ķ�
deg_row = deg_row .* spones(Wij_n); % ֻ�������Ӳ�Ϊ0�Ķ�Ӧ��Ԫ�أ���Ϊ�н����Ľڵ����ǲż������ǵ�JB
deg_row = triu(deg_row) + triu(deg_row');
Wij_d = deg_row.*spones(Wij_n)-Wij_n;
sim = triu(Wij_n ./ Wij_d);
sim = sim + sim';
sim = sim -diag(diag(sim));
sim(isnan(sim)) = 0; 
sim(isinf(sim)) = 0;
end

