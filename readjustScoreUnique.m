%% 在re-adjustScore函数基础上。代码验证正确。
function score1 = readjustScoreUnique( score, adjList, mu, sigma)
% 把原来的分数s， adjust为PNR(s)
% 对于wikibooks，大多数的link
exceptZeros = score > 0;                          % 不对分数为0的link进行调整
step = adjList(2,1)-adjList(1,1);
bin_theta = adjList(1,1) - step;
score = score - bin_theta;
binIndex = floor(score/step)+1;                   % 注意，若去除0的hybriddistribution，这里把0置为第0个bin；否则，会置为第1个bin
maxbin = max(max(binIndex));
[pnr_sort,index] = sort(adjList(:, 2), 1, 'descend');
for i = 1:1:size(adjList,1)
    if i>= 2 && i <= 20 % 设定高斯分布差异的范围[a,b]，有时对bin 1/2不高斯区别或者只对高值bin做prpn滤波，效果会好到1%-2%）
        binIndexNum = sum(sum(binIndex == i));        % 计算落在第i个bin里面的边的数目
        theta = abs(mu + sigma * randn(binIndexNum, 1)); % 正态分布偏移值theta，注意，非0值使得0>负数，从而把0推荐而不是把其他推荐
        theta = normScore(theta, 'matrix');
        inc_index = find(pnr_sort == adjList(i, 2));
        inc  = 0;% 不超过下一个比它大的PNR，可以修改这里
        if (inc_index(1) > 1 )
            inc = pnr_sort(inc_index(1) - 1) - pnr_sort(inc_index(1));
        end
        theta =  theta * inc;
        binIndex(binIndex==i) = adjList(i,2) + theta;
    else
        binIndex(binIndex==i) = adjList(i,2);
    end
end
binIndex(binIndex==(i+1)) = adjList(i,2);         % 最后一个bin右区间为闭

% %% 2018.12.17添加 
% % 剩下的bin设置为最高值
% for j = (i+2) : 1 : maxbin
%     binIndex(binIndex==j) = max(adjList(:,2));
% end
% %% 2018.12.17添加 

score1 = binIndex;
score1 = score1 .* exceptZeros;                   % 注意，若在不去除0的hybriddistribution这种情况，0会置为第1个bin.这行代码防止这种情况
end
