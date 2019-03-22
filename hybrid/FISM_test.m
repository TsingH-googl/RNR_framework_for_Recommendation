function X_fism = FISM_test()

data     =  load('TrainX4.txt');
user_id  =  data(:,1);
item_id  =  data(:,2);
rating   =  data(:,3);

R = sparse(user_id, item_id, rating, 943, 1682, length(user_id));
R = logical(R);
v = ones(1,943);
w = ones(1,1682);

Predict = FISMrmse_Learn(R, 1682, 943, 96, v, w, 0.4);

%%%%FISM SORT
X_fism = ones(943,1682);
X_fism = ones(943,1682)-abs(X_fism-Predict);

end %function