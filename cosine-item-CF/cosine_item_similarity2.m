function sim = cosine_item_similarity2( train)
[userNum, itemNum] = size(train);
sim = zeros(itemNum); % 定义item-similarity矩阵
   for i = 1:1:itemNum
    for j = (i+1):1:itemNum
        N_i = train(:,i);
        N_j = train(:,j);
        N_ij =  N_i.*N_j;
        temp = nnz(N_ij) / sqrt(nnz(N_i)*nnz(N_j));% 注意：这里要避免NaN值（val/0，inf/inf）等，因为有些物品没人买！
        sim(i,j) = temp;
    end
    end
sim =  sim + sim';
sim(isnan(sim)) = 0; 
sim(isinf(sim)) = 0;
end

