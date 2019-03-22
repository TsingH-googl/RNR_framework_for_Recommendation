It = load('TestX4.txt'); 

[X_fism,Y_fism] = sort(M_FISM, 2, 'descend');
[X_cb,Y_cb]     = sort(M_CB,2,'descend');
[X_demo,Y_demo] = sort(M_Demo,2,'descend');

n = 35;

hit_fism = HitRate_N(Y_fism,It,n);
hit_cb   = HitRate_N(Y_cb,It,n);
hit_demo = HitRate_N(Y_demo,It,n);

[hit,ahit] = HR_ARHR_N(Y_item,It,n);