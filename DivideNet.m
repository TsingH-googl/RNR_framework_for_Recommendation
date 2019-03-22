% ע�⣺�����Ƿָ�������磬�������罻���硣������ȷ��³���Ժ�
function [train, probe] = DivideNet(net, pH); 
net = spones(net);
%% ��ϡ�����net�ָ�ΪpH��probe set��1 - pH��train set
 [i,j, val] = find(net > 0);
 linklist = [i,j,val];
 [ndata, D] = size(linklist);%ndata����������D��������
 TrainingLinkNum = int64 ((1-pH)*ndata);%training set��link��Ŀ
 ProbeLinkNum = int64 (ndata - TrainingLinkNum);%probe set��link��Ŀ
 R = randperm(ndata);%1��ndata��Щ��������ң��õ�һ�������������
 linklist_train = linklist(   R(  1:TrainingLinkNum   ) ,:);  %��R������ǰ(1-pH)*ndata�����ݵ���Ϊtraining set
 linklist_probe = linklist(   R(  TrainingLinkNum+1 :ndata    ) ,:);%��R������ʣ�µ����ݵ���Ϊprobe set

 [userNum itemNum] = size(net);
% train set����probe set���п��������ֵ��user�����ֵ��itemû�б���������������sub2int����ȥ��̫��ʱ����ˣ�������linklist_train��linklist_probe�����һ�м������ֵ��user-item
% train(sub2ind(size(train),linklist_train(:,1),linklist_train(:,2))) = 1; %ʮ�ֺ�ʱ��
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


