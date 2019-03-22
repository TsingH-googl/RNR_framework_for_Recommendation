function PREDICT = FISMrmse_Learn(R, n_items, n_users, n_lfactors, v, w, alpha)

 %%%%%initializing variables
 l_rate     =  0.001;
 beta       =  8e-4;
 lambda     =  0.1;
 gamma      =  1e-4;
 rmin       =  -0.001;
 rmax       =  0.001;
 P          =  (rmax-rmin).*rand(n_items, n_lfactors) + rmin;
 Q          =  (rmax-rmin).*rand(n_items, n_lfactors) + rmin;
 iter       =  0;
 maxIter    =  5;
 PREDICT    =  zeros(n_users, n_items);
 count      =  1;
 rho        =  3;
 threshold  =  rho*nnz(R);
 
 %%%%%iterations
 while iter<maxIter,
 
     %%%sampling
     newR = SampleZeroes(R,threshold,n_users,n_items);
     
     for i=1:n_users,
         [~, cols, ~] = find(newR(i,:));         
         
         if length(cols)>1,
             x = sum(P(cols,:),1);
             X = repmat(x, length(cols),1);
             X = X - P(cols,:);
             Z = ones(1,length(cols));
                
             for j=1:length(cols),
                 Z(1,j) = X(j,:)*transpose(Q(cols(j),:)); %%changed here cols(j)
             end %inner for
             
             PREDICT(i,cols) = v(i)*ones(1,length(cols))+ w(cols) + ((length(cols)-1)^(-alpha))*Z;
             error = newR(i,cols) - PREDICT(i,cols);
            
             %%%updating biases
             v(i) = v(i) + (l_rate)*(norm(error,2) - (lambda*v(i)));
             w(cols) = w(cols)+ (l_rate)*(error - (gamma*w(cols)));
             
             %%%updating P and Q matrices
             ErrMatLearn = transpose(repmat(error,n_lfactors,1));
             Q(cols,:) = Q(cols,:)+ (l_rate)*((ErrMatLearn.*X)-(beta*Q(cols,:)));
             Y = repmat(sum(Q(cols,:),1),length(cols),1);
             Y = Y-Q(cols,:);
             P(cols,:) = P(cols,:)+(l_rate)*((ErrMatLearn.*((length(cols)-1)^(-alpha)*Y))-(beta*P(cols,:)));
             
         end %if
            
         count = count+1;
        
     end %for
        
     iter = iter+1;
    
 end %while
    
 
 %%PREDICTION%%
 
 for u = 1:n_users,
     [~, cols, ~] = find(PREDICT(u,:));
     x = sum(P(cols,:),1);
     X = repmat(x,n_items,1);
     X(cols,:) = X(cols,:)-P(cols,:);
     lenc = length(cols)-1;
     terms = lenc*ones(n_items,1);
     
     for i=1:n_items,
         PREDICT(u,i) = v(u)+ w(i) + (terms(i,:)^(-alpha))*(X(i,:)*transpose(P(i,:)));
     end %inner for
     
 end %outer for

end %function