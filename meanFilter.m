% ��һά����y���о�ֵ�˲���nΪģ�峤��
function yfilter = meanFilter(y, n)

mean = ones(1,n)./n;  %meanΪ1��n��ģ�壬������Ԫ�ص�ֵ��Ϊ1/n
yfilter = conv(y,mean);
yfilter=yfilter(1:length(yfilter)-length(mean)+1);

end

