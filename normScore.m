%% ������ȷ����
function result = normScore( score, sign)
%% ��score�����л����н��й�һ��
% sign = column������
% sign = row,����
% sign = matrix��������
result = score;
[row, column] = size(score);
% �������ֵ��Сֵ��һ��
if strcmp(sign,'row')==1
    for i =1:1:row
        result(i,:) = (result(i,:)-min(result(i,:)))/(max(result(i,:))-min(result(i,:)));
    end      
end
% �������ֵ��Сֵ��һ��
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

