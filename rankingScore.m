%% 计算平均排序分average ranking score，程序正确，效率还算高
function out = rankingScore( train, probe, score)
train = spones(train);
probe = spones(probe);
probe =full(probe);
[userNum, itemNum] = size(train);
score_nonexisting = score;
score_nonexisting(train>0) = 0;
[val,index] = sort(score_nonexisting,2, 'descend');
L_u = size(train,2)- sum(train,2); %计算所有用户u未选择的item数目，即是RS的分母部分
l_ui = full(sparse(userNum, 1));%用于保存用户u对所有probe中的待预测item
probe_u = sum(probe, 2);
for u =1:1:userNum
    u_item_index = find(probe(u,:));%找到用户u在probe的missing link的下标
    sum_u=0;% 统计第u个用户在测试集中未买过所有item的推荐排名之和
    if(probe_u(u)>0)
        for i = 1:1:length(u_item_index)
            sum_u = sum_u+find(index(u,:)==u_item_index(i));% 找到第u个用户在测试集的第i个物品在推荐列表中的位置
        end
    end
    l_ui(u) = sum_u;%计算每个用户对所有待预测商品的
end

out = sum(l_ui./L_u) / (nnz(probe)); % 不是除以userNum

% out =  sum(l_ui./L_u) / userNum;
            
end

