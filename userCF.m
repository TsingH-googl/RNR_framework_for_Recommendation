%% �����˸Ľ���userCF��intersect��find��sub2ind�Ⱥ���ʮ�ֺ�ʱ��Ӧ��ת��Ϊ��������ˡ���������ȷ��Ч�ʸ�
function score = userCF( train, sim, K)
[userNum, itemNum] = size(train);
KIndex = sparse(userNum, userNum);
[sA ,index] = sort(sim, 2 ,'descend'); % �������Ծ����н������򣬲��ı�sim��Ч�ʸ�
for u =1:1:userNum
    KIndex(u,index(u,1:K)) = 1; % ����ÿ���û����Ƶ�ǰK���û���������KIndex����
end
Ksim = KIndex .* sim; % ����ÿ���û��Ե�ǰ���Ƶ�ǰK���û���������ֵsim(u, v)����������train���
score = sparse(Ksim * train); % ��train��ˣ�����ǰK�������û�ϲ��item��simֵ�ܺ�
end