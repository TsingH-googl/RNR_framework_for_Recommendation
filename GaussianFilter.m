% ���ܣ���һά�źŵĸ�˹�˲���ͷβr/2���źŲ������˲�
% r     :��˹ģ��Ĵ�С�Ƽ�����
% sigma :��׼��
% y     :��Ҫ���и�˹�˲�������
function y_filted = GaussianFilter(r, sigma, y)

% ����һά��˹�˲�ģ��
GaussTemp = ones(1,r*2-1);
for i=1 : r*2-1
    GaussTemp(i) = exp(-(i-r)^2/(2*sigma^2))/(sigma*sqrt(2*pi));
end

% ��˹�˲�
y_filted = y;
for i = r : length(y)-r+1
    y_filted(i) = y(i-r+1 : i+r-1)*GaussTemp';
end