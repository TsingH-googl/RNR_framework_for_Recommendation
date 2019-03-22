%% 程序正确无误，注意，probe必须为有评分数据rating的
function out = RMSE( score, probe  )
score_pre = score .* spones(probe);
score_pre = normScore( score_pre, 'matrix');
score_pro = probe;
score_pro = normScore( score_pro, 'matrix');
factor = score_pre - score_pro;
factor = factor .* factor;
out = sqrt(sum(sum(factor)) ./ nnz(probe) );


end

