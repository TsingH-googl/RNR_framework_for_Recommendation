function score = PMF( train_rating, maxepoch, num_feat)
% Version 1.000
%
% Code provided by Ruslan Salakhutdinov
%
% Permission is granted for anyone to copy, use, modify, or distribute this
% program and accompanying programs and documents for any purpose, provided
% this copyright notice is retained and prominently displayed, along with
% a note saying that the original programs are available from our
% web page.
% The programs and documents are distributed without any warranty, express or
% implied.  As the programs were written for research purposes only, they have
% not been tested to the degree that would be advisable in any important
% application.  All use of these programs is entirely at the user's own risk.

% if restart==1
epsilon=50; % Learning rate
lambda  = 0.01; % Regularization parameter
momentum=0.8;

epoch=1;

% train_vec:  Triplets: {user_id, movie_id, rating}
train_vec = matrix2vec(train_rating);
mean_rating = mean(train_vec(:,3));

pairs_tr = length(train_vec); % training data
%   pairs_pr = length(probe_vec); % validation data

[num_p, num_m] = size(train_rating);
numbatches= 9; % Number of batches     （若程序出错，则是这里的问题，）
%   num_m = 3952;  % Number of movies
%   num_p = 6040;  % Number of users
%   num_feat = 10; % Rank 10 decomposition

N = floor(size(train_vec, 1) * (1/numbatches)); % number training triplets per batch

w1_M1     = 0.1*randn(num_m, num_feat); % Movie feature vectors
w1_P1     = 0.1*randn(num_p, num_feat); % User feature vecators
w1_M1_inc = zeros(num_m, num_feat);
w1_P1_inc = zeros(num_p, num_feat);

% end


for epoch = epoch:maxepoch
    rr = randperm(pairs_tr);
    train_vec = train_vec(rr,:);
    clear rr
    
    for batch = 1:numbatches
     %   fprintf(1,'epoch %d batch %d \r',epoch,batch);
        %         N = 100000; % number training triplets per batch
        
        aa_p   = double(train_vec((batch-1)*N+1:batch*N,1));
        aa_m   = double(train_vec((batch-1)*N+1:batch*N,2));
        rating = double(train_vec((batch-1)*N+1:batch*N,3));
        
        rating = rating-mean_rating; % Default prediction is the mean rating.
        
        %%%%%%%%%%%%%% Compute Predictions %%%%%%%%%%%%%%%%%
        pred_out = sum(w1_M1(aa_m,:).*w1_P1(aa_p,:),2);
        f = sum( (pred_out - rating).^2 + ...
            0.5*lambda*( sum( (w1_M1(aa_m,:).^2 + w1_P1(aa_p,:).^2),2)));
        
        w1_M1(isnan(w1_M1)) = 0; w1_M1(isinf(w1_M1)) = 0;
        w1_P1(isnan(w1_P1)) = 0; w1_P1(isinf(w1_P1)) = 0;
        
        %%%%%%%%%%%%%% Compute Gradients %%%%%%%%%%%%%%%%%%%
        IO = repmat(2*(pred_out - rating),1,num_feat);
        Ix_m=IO.*w1_P1(aa_p,:) + lambda*w1_M1(aa_m,:);
        Ix_p=IO.*w1_M1(aa_m,:) + lambda*w1_P1(aa_p,:);
        
        dw1_M1 = zeros(num_m,num_feat);
        dw1_P1 = zeros(num_p,num_feat);
        
        for ii=1:N
            dw1_M1(aa_m(ii),:) =  dw1_M1(aa_m(ii),:) +  Ix_m(ii,:);
            dw1_P1(aa_p(ii),:) =  dw1_P1(aa_p(ii),:) +  Ix_p(ii,:);
        end
        
        %%%% Update movie and user features %%%%%%%%%%%
        
        w1_M1_inc = momentum*w1_M1_inc + epsilon*dw1_M1/N;
        w1_M1 =  w1_M1 - w1_M1_inc;
        
        w1_M1(isnan(w1_M1)) = 0; w1_M1(isinf(w1_M1)) = 0;
        w1_P1(isnan(w1_P1)) = 0; w1_P1(isinf(w1_P1)) = 0;
        
        w1_P1_inc = momentum*w1_P1_inc + epsilon*dw1_P1/N;
        w1_P1 =  w1_P1 - w1_P1_inc;
        
        w1_M1(isnan(w1_M1)) = 0; w1_M1(isinf(w1_M1)) = 0;
        w1_P1(isnan(w1_P1)) = 0; w1_P1(isinf(w1_P1)) = 0;
    end
    
    %%%%%%%%%%%%%% Compute Predictions after Paramete Updates %%%%%%%%%%%%%%%%%
    pred_out = sum(w1_M1(aa_m,:).*w1_P1(aa_p,:),2);
    
    w1_M1(isnan(w1_M1)) = 0; w1_M1(isinf(w1_M1)) = 0;
    w1_P1(isnan(w1_P1)) = 0; w1_P1(isinf(w1_P1)) = 0;
    
    f_s = sum( (pred_out - rating).^2 + ...
        0.5*lambda*( sum( (w1_M1(aa_m,:).^2 + w1_P1(aa_p,:).^2),2)));
    err_train(epoch) = sqrt(f_s/N);
    
    w1_M1(isnan(w1_M1)) = 0; w1_M1(isinf(w1_M1)) = 0;
    w1_P1(isnan(w1_P1)) = 0; w1_P1(isinf(w1_P1)) = 0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Compute predictions on the validation set %%%%%%%%%%%%%%%%%%%%%%
    %     NN=pairs_pr;
    
    %     aa_p = double(probe_vec(:,1));
    %     aa_m = double(probe_vec(:,2));
    %     rating = double(probe_vec(:,3));
    
    %     pred_out = sum(w1_M1(aa_m,:).*w1_P1(aa_p,:),2) + mean_rating;
    %     ff = find(pred_out>5); pred_out(ff)=5; % Clip predictions
    %     ff = find(pred_out<1); pred_out(ff)=1;
    
    %     err_valid(epoch) = sqrt(sum((pred_out- rating).^2)/NN);
    %     fprintf(1, 'epoch %4i batch %4i Training RMSE %6.4f  Test RMSE %6.4f  \n', ...
    %         epoch, batch, err_train(epoch), err_valid(epoch));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %   if (rem(epoch,10))==0
    %      save pmf_weight w1_M1 w1_P1
    %   end
    
end

w1_M1(isnan(w1_M1)) = 0; w1_M1(isinf(w1_M1)) = 0;
w1_P1(isnan(w1_P1)) = 0; w1_P1(isinf(w1_P1)) = 0;

score = w1_P1 * w1_M1' + mean_rating;

score (isnan(score )) = 0; score (isinf(score )) = 0;
% score(score<1) = 0;
% % score(score>5) = 5;

end

