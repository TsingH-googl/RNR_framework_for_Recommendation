%% ����׼ȷ�ʣ�precision�����ٻ��ʣ�recall����������ȷ
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

%% ��׼ȷ��
precision = nnz(result) / (topL*userNum); % ׼ȷ��
% precision = sum(  sum(result, 2) ./  topL  ) / nnz( sum(probe, 2) ); % ׼ȷ�ʣ�ÿ���û���׼ȷ����ƽ����;��˶���

%% ���ٻ���
recall =    nnz(result) / nnz(probe);      % �ٻ���

%% ��������HR
% hr =        nnz(result) / userNum; % ����˵HR��[0, 1]��Χ��
hr = nnz( sum(result, 2) ) / userNum;

%% ��ARHR��Ӧ���ǶԵ�
sum_arhr = 0.0;
result_u = sum(result, 2);
for u = 1 : 1 : userNum
    if result_u(u) > 0
        u_item_index = find(result(u,:)); % ��u���û���hits
        for i = 1 : 1 : length(u_item_index)
            pi = find(index(u,:)==u_item_index(i));
            sum_arhr = sum_arhr + 1/ pi;
        end
    end
end

arhr = sum_arhr / userNum;

end
