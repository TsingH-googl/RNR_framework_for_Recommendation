clear all;
%% ��ȡԭʼ����
data = (load('D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\u.data'));
data = sortrows(data , 4);
data(:,5) = formatdate(data(:,4)); % ʱ�����ݰ���������

%% ����ѵ����������ݼ�
pH =  0.2; % ���Լ��Ĵ�С
testLength = length(data)*pH;
trainLength = length(data) - testLength;
train = data(1:trainLength,:);
test = data(trainLength+1:length(data),:);

%% ����ѵ����������pearson��������user-similarity
userNum = max(data(:,1));
itemNum = max(data(:,2));
ratingTrain = sparse(userNum ,itemNum);
ratingTrain(  sub2ind(size(ratingTrain)  , train(:,1),train(:,2))) = train(:,3);
% ratingTrain = spconvert(train(:,1:3));
[sim p ] = corrcoef(full(ratingTrain')); % ���У�p(i,j)ָ����sim(i,j)���ϵ��ֵΪ0�����Ÿ��ʣ�1-p(i,j)ָ����sim(i,j)���ϵ��ֵΪr(i,j)�����Ÿ���
[i j] = find(p<0.05);% ����Ϊ0.05
temp(:,1) = i;temp(:,2) = j;
temp(:,3) = sim(sub2ind(size(sim),i,j));
sim_flash = spconvert(temp);
% temp = sparse(userNum ,userNum);
% temp(  sub2ind(size(temp), i, j)) = 1;
% sim_flash = sparse(sim).*temp; % ȥ������ֵС��95%�����ϵ��

% clear temp;
% �������⣺�����������ݼ���������Ϊ���������û�������ʱ������������/��ֵ�
%% 






