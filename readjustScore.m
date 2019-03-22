%% 改进的re-adjustScore代码。代码正确，效率较re-adjustScore2高。
function score1 = readjustScore( score, adjList)
% 把原来的分数s， adjust为PNR(s)
exceptZeros = score > 0; % 不对分数为0的link进行调整
step = adjList(2,1)-adjList(1,1);
bin_theta = adjList(1,1) - step;
score = score - bin_theta;
binIndex = floor(score/step)+1; % 注意，若去除0的hybriddistribution，这里把0置为第0个bin；否则，会置为第1个bin
maxbin = max(max(binIndex));
% score1 = sparse(zeros(size(score, 1), size(score, 2)));
for i = 1:1:size(adjList,1)
     binIndex(binIndex==i) = adjList(i,2); %  注意，这里把non-existing link中为0的也会置pnr(s)>0。（其他evaluator不知道会不会有影响）
end
binIndex(binIndex==(i+1)) = adjList(i,2); % 最后一个bin右区间为闭


%% 2018.12.17添加 
% 剩下的bin设置为最高值
for j = (i+2) : 1 : maxbin
    binIndex(binIndex==j) = max(adjList(:,2));
end
%% 2018.12.17添加 


score1 = binIndex;
score1 = score1 .* exceptZeros; % 注意，若在不去除0的hybriddistribution这种情况，0会置为第1个bin.这行代码防止这种情况

end

