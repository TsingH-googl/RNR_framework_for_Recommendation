%% ������ȷ��Ч��ʮ�ָ�
function sim = jaccard_user_similarity( train)
train = spones(train);
[userNum, itemNum] = size(train);
Wuv_n = train * train';
Wuv_d = sparse(userNum, userNum);
deg_row = (repmat(sum(train,2), [1, size(train,1)]))'; % ����ÿ���ڵ�Ķ�
deg_row = deg_row .* spones(Wuv_n); % ֻ�������Ӳ�Ϊ0�Ķ�Ӧ��Ԫ�أ���Ϊ�н����Ľڵ����ǲż������ǵ�JB
deg_row = triu(deg_row) + triu(deg_row');
Wuv_d = deg_row.*spones(Wuv_n)-Wuv_n;
sim = triu(Wuv_n ./ Wuv_d);
sim = sim + sim';
sim = sim -diag(diag(sim));
sim(isnan(sim)) = 0; 
sim(isinf(sim)) = 0;

end