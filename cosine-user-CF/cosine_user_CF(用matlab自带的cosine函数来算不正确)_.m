clear all;
t1= clock;
%% ��ȡѵ��������Լ�����
data = (load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u.data'));
train = (load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u5.base'));
test = (load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u5.test'));% ��֪��Ϊʲô�������test�ڵ�460��λ�û�֮��û��������ݣ�
train = sortrows(train , 4);
test = sortrows(test , 4);
train(:,5) = formatdate(train(:,4)); % ʱ�����ݰ���������
test(:,5) = formatdate(test(:,4)); % ʱ�����ݰ���������

%% ����ѵ����������pearson��������user-similarity
userNum = max(data(:,1));
itemNum = max(data(:,2));
ratingTrain = sparse(userNum ,itemNum);
ratingTrain(  sub2ind(size(ratingTrain)  , train(:,1),train(:,2))) = train(:,3);
D = pdist(~~ratingTrain, 'cosine');
sim = squareform(D);
% ratingTrain = spconvert(train(:,1:3));
% [usersim p ] = corrcoef(full(ratingTrain')); % ���У�p(i,j)ָ����sim(i,j)���ϵ��ֵΪ0�����Ÿ��ʣ�1-p(i,j)ָ����sim(i,j)���ϵ��ֵΪr(i,j)�����Ÿ���
% [i j] = find(p<0.05);% ����Ϊ0.05��ע��,finda�������ص����С�������ֵ
% temp(:,1) = i;temp(:,2) = j;
% temp(:,3) = usersim(sub2ind(size(usersim),i,j));
% sim = spconvert(temp);

%% ����user-similarity����ÿ���û�������item��probability��������scoreϡ�����
%% ע�⣬�����Ҫ���������itemҲҪ��û�������item����Ϊ����Ҫ����existing ��nonexisting�ķ����ֲ�
[sA index] = sort(sim, 2 ,'descend'); % ��user�����Ծ���sim_flash���н�������
K = 10; % ѡ��ǰK���뵱ǰ�û������Ƶ�ǰK���û�
% �����u���û�������item��probability, p(u, i)
score = sparse(userNum, itemNum);
for u = 1:1:userNum
    for i = 1:1:itemNum
        s_uk = index(u,1:K); % ���û�u���Ƶ�ǰK���û�������ֵ
        [N_i_index j] = find(ratingTrain(:,i)>0); % ����item i�������û�������ֵ
        v_intersect = (intersect(s_uk, N_i_index)); % ����p(u,i)��ʽ�����㽻��v�ҷ�ֹ�ظ�v
        p_ui = sum( sim(u,v_intersect) );
        score(u,i) = full(p_ui);
    end
end

%% ����score���󣬶�ÿ��user�����Ƽ�item��
%% ���Ҽ���׼ȷ�ʣ��ٻ��ʣ������ʣ����жȡ�
%  ���ȷ�������������score_existing��û���������score_nonexisting
score_existing = sparse(userNum, itemNum);
score_existing = sparse(~~ratingTrain)  .*  score;
score_nonexisting = sparse(userNum, itemNum);
score_nonexisting = sparse(~ratingTrain)  .*  score;
% �����ٻ���recall�����ݲ��Լ���ÿ���û�ȱ����Ŀ�����Ƽ�����TopN�Ƽ�
ratingTest = sparse(userNum ,itemNum);
ratingTest(  sub2ind(size(ratingTest)  , test(:,1),test(:,2))) = test(:,3);
ratingTest_norm = ~~ratingTest;
score_nonexisting_norm = ~~score_nonexisting;
[val index] = sort(score_nonexisting,2, 'descend');
% �ҳ��Ƽ�׼ȷ��item������ͳ��������Ŀ
sum_correct = 0; % ע�⣺sum�������ܺ�sum����һ��ʹ�ã�������֡��±���������Ϊ���������ͻ��߼����͡�����
for u = 1:1:userNum  % ����Ҫ�������е��û�����Ϊ��Щ�û���test��û������
    u_actual = ratingTest_norm(u,:);
    u_topN = sum(u_actual);
    [i j] = find(ratingTest_norm(u,:)>0);% �����u���û�ʵ����Ķ�����������ע�⣬��������j��
    u_correct = length((intersect(index(u,1:u_topN),j)));
    sum_correct = sum_correct + u_correct;
end

precision = sum_correct / length(test); % u1:10.67%, u2;  , u3: , u4:5.61%  , u5: 6.52%�����������ֱ�׼��Ϊ1��Ϊ6.44%����
    
t2= clock;
etime(t2,t1);





