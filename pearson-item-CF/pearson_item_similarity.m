%% ������ȷ��Ч�ʸ�
function  sim_flash = pearson_item_similarity( train)
[itemsim ,p ] = (corrcoef(full(train))); % ���У�p(i,j)ָ����sim(i,j)���ϵ��ֵΪ0�����Ÿ��ʣ�1-p(i,j)ָ����sim(i,j)���ϵ��ֵΪr(i,j)�����Ÿ��ʡ��������Ϊfull������ڴ治��
sim_flash = (p<0.05).*itemsim;% ����Ϊ0.05��ע��,find�������ص����С�������ֵ
sim_flash(isnan(sim_flash)) = 0; 
sim_flash(isinf(sim_flash)) = 0;
end