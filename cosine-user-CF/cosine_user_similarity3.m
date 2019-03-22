%% ������ȷ���δ֪
function sim = cosine_user_similarity3( train)
[userNum, itemNum] = size(train);
Wij_n = train * train';%����
Wij_d = sparse(userNum, userNum); %��ĸ

% deg_row = sparse((repmat(sum(train,2), [1,size(train,1)]))'); % ����ÿ���ڵ�Ķ�
% deg_row = deg_row .* (deg_row');

deg_row =sparse(userNum, userNum);
temp = sparse(sum(train,2)');
for i=1:1:userNum
    temp2 = repmat(temp(1),[1,size(train,1)]);
    deg_row(i,:) = sparse(temp.* temp2); 
end


deg_row = deg_row .* spones(Wij_n); % ֻ�������Ӳ�Ϊ0�Ķ�Ӧ��Ԫ�أ���Ϊ�н����Ľڵ����ǲż������ǵ�JB
Wij_d = deg_row.*spones(Wij_n);
sim = triu(Wij_n ./ sqrt(Wij_d));

sim = sim + sim';
sim = sim -diag(diag(sim));
sim(isnan(sim)) = 0; 
sim(isinf(sim)) = 0;
end

