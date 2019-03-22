function sim = jaccard_user_similarity2( train)
[userNum, itemNum] = size(train);
sim = zeros(userNum);
for u = 1:1:userNum
    for v = (u+1):1:userNum
        N_u = train(u,:);
        N_v = train(v,:);
        N_uv =  N_u.*N_v;
        N_uandv = N_u + N_v;
        sim(u,v) = nnz(N_uv) / nnz(N_uandv);
    end
end
sim =  sim + sim';
sim(isnan(sim)) = 0; 
sim(isinf(sim)) = 0;

end


% 这个正确，但是更加慢！
% function sim = jaccard_user_similarity3( train)
% [userNum, itemNum] = size(train);
% Wuv_n = train * train';
% Wuv_d = sparse(userNum, userNum);
% for u =1:1:userNum
%     for v = (u+1):1:userNum
%         Wuv_d(u,v) = nnz(train(u,:) | train(v,:));
%     end
% end
% Wuv_d = sparse(Wuv_d + Wuv_d'); 
% sim = Wuv_n ./ Wuv_d;
% sim(isnan(sim)) = 0; 
% sim(isinf(sim)) = 0;
% 
% end