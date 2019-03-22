%% ������ȷ����Ч�ʵ���
function  sim_flash = pearson_item_similarity2( train)
[itemsim ,p ] = corrcoef(full(train)); % ���У�p(i,j)ָ����sim(i,j)���ϵ��ֵΪ0�����Ÿ��ʣ�1-p(i,j)ָ����sim(i,j)���ϵ��ֵΪr(i,j)�����Ÿ���
[i, j] = find(p<0.05);% ����Ϊ0.05��ע��,find�������ص����С�������ֵ
temp(:,1) = i;temp(:,2) = j;
temp(:,3) = itemsim(sub2ind(size(itemsim),i,j));
sim_flash = sparse(size(train,2), size(train,2));
sim_flash(  sub2ind(size(sim_flash), temp(:,1),temp(:,2))) = temp(:,3); % ��spcovert��Ȼ�ܿ죬���ǻ�ʹ��
sim_flash(isnan(sim_flash)) = 0; 
sim_flash(isinf(sim_flash)) = 0;
end