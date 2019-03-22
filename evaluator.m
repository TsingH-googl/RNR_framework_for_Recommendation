%% 计算准确率（precision）、召回率（recall）。代码正确
function [precision, recall, hr, arhr] = evaluator( train ,probe, score, topL)

train = spones(train);
probe = spones(probe);

[userNum, itemNum] = size(train);
score_nonexisting = score;
score_nonexisting(train>0) = 0;
[val,index] = sort(score_nonexisting,2, 'descend');
LIndex = sparse(zeros(userNum, itemNum));
for u = 1:1:userNum
    LIndex(u,index(u,1:topL)) = 1;
end

result = LIndex .* probe;

%% 求准确率
precision = nnz(result) / (topL*userNum); % 准确率
% precision = sum(  sum(result, 2) ./  topL  ) / nnz( sum(probe, 2) ); % 准确率（每个用户的准确率求平均）;差不了多少

%% 求召回率
recall =    nnz(result) / nnz(probe);      % 召回率

%% 求命中率HR
% hr =        nnz(result) / userNum; % 文中说HR是[0, 1]范围的
hr = nnz( sum(result, 2) ) / userNum;

%% 求ARHR，应该是对的
sum_arhr = 0.0;
result_u = sum(result, 2);
for u = 1 : 1 : userNum
    if result_u(u) > 0
        u_item_index = find(result(u,:)); % 第u个用户的hits
        for i = 1 : 1 : length(u_item_index)
            pi = find(index(u,:)==u_item_index(i));
            sum_arhr = sum_arhr + 1/ pi;
        end
    end
end

arhr = sum_arhr / userNum;

end
