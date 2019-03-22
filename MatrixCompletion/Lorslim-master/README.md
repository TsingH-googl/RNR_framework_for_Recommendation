Lorslim
======================================
Code :Example code for LorSLIM

Data: Processed data from ML100K, including training data and testing data 

To check the result of LorSLIM on ML100K, just do as follows:
    1.Start parallel job: matlabpool local 4
    2.load matrix from folder data
	3.Run LorSLIM.m: LorSLIM(Trainn,test,test_zhong,1e-3,10,5,3,8,10)
	4.Close parallel job: matlabpool close