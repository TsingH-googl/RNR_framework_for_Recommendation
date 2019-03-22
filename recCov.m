%% 计算推荐覆盖率recomendation coverage，程序正确
function out = recCov( train, score, topL)
[userNum, itemNum] = size(train);
score_nonexisting = score;
score_nonexisting(train>0) = 0;
[val,index] = sort(score_nonexisting,2, 'descend');
LIndex =sparse(userNum, itemNum);
for u = 1:1:userNum  
    LIndex(u,index(u,1:topL)) = 1;
end

out = nnz(sum(LIndex,1))/itemNum;

end