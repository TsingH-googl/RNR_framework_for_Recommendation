%% 程序正确无误。
function result = normScore( score, sign)
%% 对score按照行或者列进行归一化
% sign = column，按列
% sign = row,按行
% sign = matrix，按矩阵
result = score;
[row, column] = size(score);
% 按行最大值最小值归一化
if strcmp(sign,'row')==1
    for i =1:1:row
        result(i,:) = (result(i,:)-min(result(i,:)))/(max(result(i,:))-min(result(i,:)));
    end      
end
% 按列最大值最小值归一化
if strcmp(sign,'column')==1
    for i =1:1:column
        result(:,i) = (result(:,i)-min(result(:,i)))/(max(result(:,i))-min(result(:,i)));
    end 
end
if strcmp(sign,'matrix')==1
   result = (result- min(min(result)))/(max(max(result))-min(min(result)));
end
result(isnan(result)) = 0;
result(isinf(result)) = 0;
end

