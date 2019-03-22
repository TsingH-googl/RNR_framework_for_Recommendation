% 对一维数据y进行均值滤波，n为模板长度
function yfilter = meanFilter(y, n)

mean = ones(1,n)./n;  %mean为1×n的模板，各数组元素的值均为1/n
yfilter = conv(y,mean);
yfilter=yfilter(1:length(yfilter)-length(mean)+1);

end

