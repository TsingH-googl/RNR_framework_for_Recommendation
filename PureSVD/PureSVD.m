%% 代码正确无误
function out = PureSVD( train, svd_k, svd_maxit)

s = struct('maxit',svd_maxit); % 通过结构体指定pureSvd的最大迭代次数
[U, S, V] = svds(train, svd_k, 'L', s);
out = (U * S * V');

end

