function  score = FISM( train, FISM_n_lfactors, FISM_alpha)
% ml-100k£ºn_lfactors = 96, alpha = 0.5
[userNum, itemNum] = size(train);
train = logical(train);
v = ones(1,userNum);
w = ones(1,itemNum);

Predict = FISMrmse_Learn(train, itemNum, userNum, FISM_n_lfactors, v, w, FISM_alpha);

%%%%FISM SORT
X_fism = ones(userNum, itemNum);
X_fism = ones(userNum, itemNum)-abs(X_fism-Predict);
score = normalizing(X_fism);
end

