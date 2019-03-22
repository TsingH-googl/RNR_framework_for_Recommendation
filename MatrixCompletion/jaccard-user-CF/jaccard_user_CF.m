clear all;
t1= clock;
%% ��ȡѵ��������Լ�����
data = (load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u.data'));
train = (load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u1.base'));
test = (load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u1.test'));% ��֪��Ϊʲô�������test�ڵ�460��λ�û�֮��û��������ݣ�
train = sortrows(train , 4);
test = sortrows(test , 4);
train(:,5) = formatdate(train(:,4));  % ʱ�����ݰ���������
test(:,5) = formatdate(test(:,4));    % ʱ�����ݰ���������

%% ����ѵ�����������������ƶ�����user-similarity
userNum = max(data(:,1));
itemNum = max(data(:,2));
ratingTrain = sparse(userNum ,itemNum);
ratingTrain(  sub2ind(size(ratingTrain)  , train(:,1),train(:,2))) = train(:,3);
ratingTrain_norm = ~~ratingTrain;
sim = jaccard_user_similarity( ratingTrain_norm);

%% ����ÿ���û�������item��probability��������scoreϡ�����
%% ����Ҫ����existing ��nonexisting�ķ����ֲ�
K = 3;                               % ѡ��ǰK���뵱ǰ�û������Ƶ�ǰK���û�
score = userCF( ratingTrain, sim, userNum, itemNum, K);

%% ����score���󣬶�ÿ��user�����Ƽ�item��
%% ����׼ȷ�ʣ��ٻ��ʣ������ʣ����жȡ�
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
precision = precision( score_nonexisting,max(test(:,1)) ,ratingTest_norm);% ����Ҫ�������е��û�����Ϊ��Щ�û���test��û������

%                             pearson_user_CF : % u1:41.49%, u2; 36.59% , u3: , u4:33.73%  , u5:34.74% ��
                           % u1:41.20%, u2; 36.60%  , u3: , u4:  , u5:34.19%  ��
    
t2= clock;
etime(t2,t1);





