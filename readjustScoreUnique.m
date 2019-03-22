%% ��re-adjustScore���������ϡ�������֤��ȷ��
function score1 = readjustScoreUnique( score, adjList, mu, sigma)
% ��ԭ���ķ���s�� adjustΪPNR(s)
% ����wikibooks���������link
exceptZeros = score > 0;                          % ���Է���Ϊ0��link���е���
step = adjList(2,1)-adjList(1,1);
bin_theta = adjList(1,1) - step;
score = score - bin_theta;
binIndex = floor(score/step)+1;                   % ע�⣬��ȥ��0��hybriddistribution�������0��Ϊ��0��bin�����򣬻���Ϊ��1��bin
maxbin = max(max(binIndex));
[pnr_sort,index] = sort(adjList(:, 2), 1, 'descend');
for i = 1:1:size(adjList,1)
    if i>= 2 && i <= 20 % �趨��˹�ֲ�����ķ�Χ[a,b]����ʱ��bin 1/2����˹�������ֻ�Ը�ֵbin��prpn�˲���Ч����õ�1%-2%��
        binIndexNum = sum(sum(binIndex == i));        % �������ڵ�i��bin����ıߵ���Ŀ
        theta = abs(mu + sigma * randn(binIndexNum, 1)); % ��̬�ֲ�ƫ��ֵtheta��ע�⣬��0ֵʹ��0>�������Ӷ���0�Ƽ������ǰ������Ƽ�
        theta = normScore(theta, 'matrix');
        inc_index = find(pnr_sort == adjList(i, 2));
        inc  = 0;% ��������һ���������PNR�������޸�����
        if (inc_index(1) > 1 )
            inc = pnr_sort(inc_index(1) - 1) - pnr_sort(inc_index(1));
        end
        theta =  theta * inc;
        binIndex(binIndex==i) = adjList(i,2) + theta;
    else
        binIndex(binIndex==i) = adjList(i,2);
    end
end
binIndex(binIndex==(i+1)) = adjList(i,2);         % ���һ��bin������Ϊ��

% %% 2018.12.17��� 
% % ʣ�µ�bin����Ϊ���ֵ
% for j = (i+2) : 1 : maxbin
%     binIndex(binIndex==j) = max(adjList(:,2));
% end
% %% 2018.12.17��� 

score1 = binIndex;
score1 = score1 .* exceptZeros;                   % ע�⣬���ڲ�ȥ��0��hybriddistribution���������0����Ϊ��1��bin.���д����ֹ�������
end
