%% 根据时间信息划分网络，程序正确效率高。指定0~1的ratio，表示train或probe取自data哪些时间戳片段
function [train, probe] = timeDivideSeg(data, train_start_ratio, train_end_ratio, probe_start_ratio, probe_end_ratio)
data = sortrows(data, 4 ); % 第4列为时间戳
train_start = int32(train_start_ratio * size(data,1))+1;
train_end = int32(train_end_ratio * size(data,1));
probe_start = int32(probe_start_ratio * size(data,1))+1;
probe_end = int32(probe_end_ratio * size(data,1));
data_train = data(train_start:train_end,:);
data_probe = data(probe_start:probe_end,:);

%% 以下代码为了防止train以及probe中的有些边不存在
userNum= max(data(:,1));
itemNum = max(data(:,2));

if max(data_train(:,1)) < userNum || max(data_train(:,2)) < itemNum
    temp = [userNum,itemNum, 0, 0];
    data_train(size(data_train,1)+1,:) = temp;
end


if max(data_probe(:,1)) < userNum || max(data_probe(:,2)) < itemNum
    temp = [userNum,itemNum, 0, 0];
    data_probe(size(data_probe,1)+1,:) = temp;
end

train = spconvert(data_train(:,[1 2 3]));
probe = spconvert(data_probe(:,[1 2 3]));
train = spones(train);
probe = spones(probe);

end
