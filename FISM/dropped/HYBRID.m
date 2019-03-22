
R_FISM = FISM_test();
R_CB   = CB_learn();
% R_Demo = Demo_Test();

M_FISM = normalizing(R_FISM);
M_CB   = normalizing(R_CB);
% M_Demo = normalizing(R_Demo);

wf   = 0.8;
wcb  = 0.2;
% wd   = 0.0;

M_FINAL = wf*M_FISM + wcb*M_CB;

[X_wt,Y_item] = sort(M_FINAL, 2,'descend');