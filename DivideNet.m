% 注意：这里是分割二分网络，而不是社交网络。代码正确，鲁棒性好
function [train, probe] = DivideNet(net, pH); 
net = spones(net);
%% 对稀疏矩阵net分割为pH的probe set与1 - pH的train set
 [i,j, val] = find(net > 0);
 linklist = [i,j,val];
 [ndata, D] = size(linklist);%ndata保存行数，D保存列数
 TrainingLinkNum = int64 ((1-pH)*ndata);%training set的link数目
 ProbeLinkNum = int64 (ndata - TrainingLinkNum);%probe set的link数目
 R = randperm(ndata);%1到ndata这些数随机打乱，得到一个随机数字序列
 linklist_train = linklist(   R(  1:TrainingLinkNum   ) ,:);  %以R索引的前(1-pH)*ndata个数据点作为training set
 linklist_probe = linklist(   R(  TrainingLinkNum+1 :ndata    ) ,:);%以R索引的剩下的数据点作为probe set

 [userNum itemNum] = size(net);
% train set或者probe set都有可能有最高值的user或最高值的item没有被包括进来，而用sub2int函数去做太耗时。因此，可以在linklist_train与linklist_probe的最后一列加上最大值的user-item
% train(sub2ind(size(train),linklist_train(:,1),linklist_train(:,2))) = 1; %十分耗时！
if (max(linklist_train(:,1))<userNum) || (max(linklist_train(:,2))<itemNum)
    [row col] = size(linklist_train);
    linklist_train(row+1,:) = [userNum, itemNum, 0];
end
if (max(linklist_probe(:,1))<userNum) || (max(linklist_probe(:,2))<itemNum)
    [row col] = size(linklist_probe);
    linklist_probe(row+1,:) = [userNum, itemNum, 0];
end

train = spconvert(linklist_train);
probe = spconvert(linklist_probe);

end


