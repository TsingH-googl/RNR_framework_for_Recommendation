%% 程序正确，但效率低下
function  sim_flash = pearson_item_similarity2( train)
[itemsim ,p ] = corrcoef(full(train)); % 其中，p(i,j)指的是sim(i,j)相关系数值为0的置信概率，1-p(i,j)指的是sim(i,j)相关系数值为r(i,j)的置信概率
[i, j] = find(p<0.05);% 置信为0.05，注意,find函数返回的是行、列坐标值
temp(:,1) = i;temp(:,2) = j;
temp(:,3) = itemsim(sub2ind(size(itemsim),i,j));
sim_flash = sparse(size(train,2), size(train,2));
sim_flash(  sub2ind(size(sim_flash), temp(:,1),temp(:,2))) = temp(:,3); % 用spcovert固然很快，但是会使得
sim_flash(isnan(sim_flash)) = 0; 
sim_flash(isinf(sim_flash)) = 0;
end