function  sim_flash = pearson_user_similarity( train)
[usersim, p ] = corrcoef(full(train')); % corrcoef∞¥¡–º∆À„
sim_flash = (p<0.05) .*  usersim;
sim_flash(isnan(sim_flash)) = 0; 
sim_flash(isinf(sim_flash)) = 0;       
       
end

