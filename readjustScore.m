%% �Ľ���re-adjustScore���롣������ȷ��Ч�ʽ�re-adjustScore2�ߡ�
function score1 = readjustScore( score, adjList)
% ��ԭ���ķ���s�� adjustΪPNR(s)
exceptZeros = score > 0; % ���Է���Ϊ0��link���е���
step = adjList(2,1)-adjList(1,1);
bin_theta = adjList(1,1) - step;
score = score - bin_theta;
binIndex = floor(score/step)+1; % ע�⣬��ȥ��0��hybriddistribution�������0��Ϊ��0��bin�����򣬻���Ϊ��1��bin
maxbin = max(max(binIndex));
% score1 = sparse(zeros(size(score, 1), size(score, 2)));
for i = 1:1:size(adjList,1)
     binIndex(binIndex==i) = adjList(i,2); %  ע�⣬�����non-existing link��Ϊ0��Ҳ����pnr(s)>0��������evaluator��֪���᲻����Ӱ�죩
end
binIndex(binIndex==(i+1)) = adjList(i,2); % ���һ��bin������Ϊ��


%% 2018.12.17��� 
% ʣ�µ�bin����Ϊ���ֵ
for j = (i+2) : 1 : maxbin
    binIndex(binIndex==j) = max(adjList(:,2));
end
%% 2018.12.17��� 


score1 = binIndex;
score1 = score1 .* exceptZeros; % ע�⣬���ڲ�ȥ��0��hybriddistribution���������0����Ϊ��1��bin.���д����ֹ�������

end

