%% ������ȷ����ʱ�٣�Ч�ʸ�
function [ auc ] = CalcAUC( train, test, score )
train = spones(train);
test = spones(test);
rand('seed',sum(100*clock))
iterNum = 1000000; % ����AUC�ĵ�������
non = 1 - train - test;
test_num = nnz(test);
non_num = nnz(non);
test_rd = ceil( test_num * rand( 1, iterNum)); % ceil������������  ��rand��������iterNum��0-1֮��������
non_rd = ceil( non_num * rand( 1, iterNum));
test_pre = score .* test;
non_pre = score .* non;
test_data =  test_pre( test == 1 )';  
non_data =  non_pre( non == 1 )';   
test_rd_score = test_data( test_rd );    
non_rd_score = non_data( non_rd );
clear test_data non_data;
n1 = length( find(test_rd_score > non_rd_score) );  
n2 = length( find(test_rd_score == non_rd_score));
auc = ( n1 + 0.5*n2 ) / iterNum;
end

