%% ������ȷ��Ч�ʸߣ�����Ҫ�Ľ��ڴ治������
function sim = cosine_user_similarity( train)
train = spones(train);
[userNum, itemNum] = size(train);
Wij_n = train * train';%����
Wij_d = sparse(userNum, userNum); %��ĸ
deg_row = sparse((repmat(sum(train,2), [1,size(train,1)]))'); % ����ÿ���ڵ�Ķ�
deg_row = deg_row .* (deg_row');
deg_row = deg_row .* spones(Wij_n); % ֻ�������Ӳ�Ϊ0�Ķ�Ӧ��Ԫ�أ���Ϊ�н����Ľڵ����ǲż������ǵ�JB
Wij_d = deg_row.*spones(Wij_n);
sim = triu(Wij_n ./ sqrt(Wij_d));

sim = sim + sim';
sim = sim -diag(diag(sim));
sim(isnan(sim)) = 0; 
sim(isinf(sim)) = 0;
end

