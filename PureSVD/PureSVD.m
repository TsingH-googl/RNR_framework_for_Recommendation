%% ������ȷ����
function out = PureSVD( train, svd_k, svd_maxit)

s = struct('maxit',svd_maxit); % ͨ���ṹ��ָ��pureSvd������������
[U, S, V] = svds(train, svd_k, 'L', s);
out = (U * S * V');

end

