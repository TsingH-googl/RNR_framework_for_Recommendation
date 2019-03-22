function PredictR = CB_learn()

    data     = load('TrainX4.txt');
    user_id = data(:,1);
    item_id = data(:,2);
    rating  = data(:,3);
    
    x = length(rating);
    T = zeros(943,1682);

    for k = 1:x
        T(user_id(k,1),item_id(k,1)) = rating(k,1);
    end
    
    load('X.mat');

    iter    = 0;
    maxIter = 3;
    l       = 0.01;
    a       = 0.1;
    m       = 1682;

    W       = randi(5,943,20);
    count   = 1;

    while iter<maxIter
        for item_id = 1:943
            for j = 1:1682,
                if(T(item_id,j)>0),
                    count = count + 1;
                    temp = W(item_id,1);
                    W(item_id,1) = W(item_id,1)-(a)*(W(item_id,:)*transpose(X(j,:))-T(item_id,j));
                    temp2 = W(item_id,1);
                    W(item_id,1) = temp;
                    W(item_id,:) = W(item_id,:) - (a)*((W(item_id,:)*transpose(X(j,:))) - T(item_id,j))*X(j,:) - (l)*W(item_id,:);
                    W(item_id,1) = temp2;
                end %if
            end %for inner
        end %for outer
        iter = iter + 1;
    end
    
    PredictR = W*transpose(X);
end