%% ����ƽ�������average ranking score��������ȷ��Ч�ʻ����
function out = rankingScore( train, probe, score)
train = spones(train);
probe = spones(probe);
probe =full(probe);
[userNum, itemNum] = size(train);
score_nonexisting = score;
score_nonexisting(train>0) = 0;
[val,index] = sort(score_nonexisting,2, 'descend');
L_u = size(train,2)- sum(train,2); %���������û�uδѡ���item��Ŀ������RS�ķ�ĸ����
l_ui = full(sparse(userNum, 1));%���ڱ����û�u������probe�еĴ�Ԥ��item
probe_u = sum(probe, 2);
for u =1:1:userNum
    u_item_index = find(probe(u,:));%�ҵ��û�u��probe��missing link���±�
    sum_u=0;% ͳ�Ƶ�u���û��ڲ��Լ���δ�������item���Ƽ�����֮��
    if(probe_u(u)>0)
        for i = 1:1:length(u_item_index)
            sum_u = sum_u+find(index(u,:)==u_item_index(i));% �ҵ���u���û��ڲ��Լ��ĵ�i����Ʒ���Ƽ��б��е�λ��
        end
    end
    l_ui(u) = sum_u;%����ÿ���û������д�Ԥ����Ʒ��
end

out = sum(l_ui./L_u) / (nnz(probe)); % ���ǳ���userNum

% out =  sum(l_ui./L_u) / userNum;
            
end

