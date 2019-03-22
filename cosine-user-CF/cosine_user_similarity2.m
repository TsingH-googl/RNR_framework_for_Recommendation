function sim = cosine_user_similarity2( train)
[userNum, itemNum] = size(train);
sim = zeros(userNum);
for u = 1:1:userNum
    for v = (u+1):1:userNum
        N_u = train(u,:);
        N_v = train(v,:);
        N_uv =  N_u.*N_v;
        sim(u,v) = nnz(N_uv) / sqrt(nnz(N_u)*nnz(N_v));
    end
end
sim =  sim + sim';
sim(isnan(sim)) = 0; 
sim(isinf(sim)) = 0;
end

