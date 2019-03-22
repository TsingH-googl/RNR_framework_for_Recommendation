%% �����˸Ľ���itemCF��intersect��find�Ⱥ���ʮ�ֺ�ʱ��Ӧ��ת��Ϊ��������ˡ���������ȷ��Ч�ʸ�
function score = itemCF( train, sim,  K)
[userNum, itemNum] = size(train);
KIndex = sparse(itemNum, itemNum);
[sA ,index] = sort(sim, 2 ,'descend'); % �������Ծ����н������򣬲��ı�sim��Ч�ʸ�
for i =1:1:itemNum
    KIndex(i,index(i,1:K)) = 1; % ����ÿ��item���Ƶ�ǰK��item��������KIndex����
end
Ksim = KIndex .*  sim; % ����ÿ��item�Ե�ǰ���Ƶ�ǰK��item��������ֵsim(i, j)����������train���
score = sparse(train * Ksim'); % ��train��ˣ�����ǰK������item��simֵ�ܺ�
end

































%% 
% function score = itemCF( ratingTrain, sim,  K)
% [userNum, itemNum] = size(ratingTrain);
% [sA ,index] = sort(sim, 2 ,'descend'); % ��item�����Ծ���sim���н�������
% % �����u���û�������item��probability, p(u, j)
% score = sparse(userNum, itemNum);
% for u = 1:1:userNum
%     for j = 1:1:itemNum
%         s_jk = index(j,1:K); % ����Ʒj���Ƶ�ǰK��item������ֵ
%         [i ,N_u_index] = find(ratingTrain(u,:)>0); % �û�u����������ƷN(u)
%         i_intersect = intersect(s_jk, N_u_index); % ����p(u,j)��ʽ�����㽻��i�ҷ�ֹ�ظ�i
%         p_uj = sum( sim(j,i_intersect) );
%         score(u,j) = full(p_uj); 
%     end
% end
% 
% 
% end
