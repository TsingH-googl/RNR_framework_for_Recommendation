%% 程序正确，耗时少，效率高
function [ auc ] = CalcAUC( train, test, score )
train = spones(train);
test = spones(test);
rand('seed',sum(100*clock))
iterNum = 1000000; % 计算AUC的迭代次数
non = 1 - train - test;
test_num = nnz(test);
non_num = nnz(non);
test_rd = ceil( test_num * rand( 1, iterNum)); % ceil函数向正无穷  ，rand函数产生iterNum个0-1之间的随机数
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

