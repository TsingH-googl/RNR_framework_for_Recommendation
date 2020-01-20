function score = basicMF( train_rating, lambda , feat_num, maxiter )
% lambda = 10;
% feat_num = 10;

% matrix factorization for recommender systems
%   @author: Junhao Hua
%   @email:  huajh7@gmail.com
%
%   create time: 2015/2/27
%   last update: 2015/2/27
%
%   reference: Koren, Yehuda, Robert Bell, and Chris Volinsky.
%           "Matrix factorization techniques for recommender systems."
%           Computer 8 (2009): 30-37.
%

train = spones(train_rating);
score = mf_resys_func( train_rating, train, feat_num, lambda, maxiter);

end

