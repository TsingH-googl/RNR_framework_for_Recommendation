function Q = SampleZeroes(R, threshold, users, items)

 i = randi(users,1,threshold);
 j = randi(items,1,threshold);
 s = ones(1,threshold);
 Q = sparse(i, j, s, users, items, threshold);
 Q = logical(Q+R);

end %function
    
        
