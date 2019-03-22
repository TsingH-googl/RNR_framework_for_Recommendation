function hr = HitRate_N(ITrain,ITest,n)
hits = 0;
total_test = length(ITest(:,1));
for i=1:total_test,
    if find(ITrain(ITest(i,1),1:n)==ITest(i,2))>0,
        hits = hits+1;
    end %if
end %for
hr = hits/total_test;
end %function