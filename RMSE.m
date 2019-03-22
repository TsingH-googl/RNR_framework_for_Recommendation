%% ������ȷ����ע�⣬probe����Ϊ����������rating��
function out = RMSE( score, probe  )
score_pre = score .* spones(probe);
score_pre = normScore( score_pre, 'matrix');
score_pro = probe;
score_pro = normScore( score_pro, 'matrix');
factor = score_pre - score_pro;
factor = factor .* factor;
out = sqrt(sum(sum(factor)) ./ nnz(probe) );


end

