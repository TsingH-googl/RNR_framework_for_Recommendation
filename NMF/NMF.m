%% 代码正确无错误
function score = NMF( train, nmf_k, nmf_maxit)

opt = statset('maxiter',nmf_maxit);
[W, H] = nnmf(train, nmf_k, 'opt', opt);

score = W * H;


end

