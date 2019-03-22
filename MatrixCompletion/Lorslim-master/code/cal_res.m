function [hr,arhr] = cal_res(W,Trainn,test,test_zhong)
%% 
% Calculate HR corresponds to N = 5, 10, 15, 20, 25 and ARHR corresponds to
% N=5
%
%% The main program
    % Normalization
    As = Trainn;
    mu=mean(Trainn,1);
    nu=(sum(Trainn.^2,1)/size(Trainn,1)).^(0.5); 
    nu=nu';
    As= ( As- repmat(mu, size(As,1),1) ) * diag(nu)^(-1);
    %Calculation
    zhong = zeros(1,5);
    po = 0;
    REC = As * W;
    hr = zeros(1,5);
    for i = 1:size(Trainn,1)
        value = REC(i,test{i});
        value1 = REC(i,test_zhong(i));
        position = length(find(value > value1)) + 1;
        for n = 5:5:25
            if((position <= n)&(value ~= min(value1)))
                zhong(n/5) = zhong(n/5) + 1;
                if n == 10
                    po = po + 1/position;
                end     
            end
        end
    end
    hr = zhong/size(Trainn,1);
    arhr = po/size(Trainn,1);
    
        
        
        
    