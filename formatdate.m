function formatdate = formatdate( stampdata )
%% 这里把时间戳转化为按每天的数据进行排序;
%% stampdata是按照时间戳‘排好序’的时间
    stampdata = stampdata - stampdata(1) + 1;
    formatdate = int32(stampdata/(3600*24)) + 1; % 转化为从第一天开始计算，因为我觉得用户在每一天的爱好，已经可以反映它们的行为信息。
end

