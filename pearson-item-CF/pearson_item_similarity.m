%% 程序正确，效率高
function  sim_flash = pearson_item_similarity( train)
[itemsim ,p ] = (corrcoef(full(train))); % 其中，p(i,j)指的是sim(i,j)相关系数值为0的置信概率，1-p(i,j)指的是sim(i,j)相关系数值为r(i,j)的置信概率。这里必须为full否则会内存不够
sim_flash = (p<0.05).*itemsim;% 置信为0.05，注意,find函数返回的是行、列坐标值
sim_flash(isnan(sim_flash)) = 0; 
sim_flash(isinf(sim_flash)) = 0;
end