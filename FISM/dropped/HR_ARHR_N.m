function [hr,ar]= HR_ARHR_N(ITrain,ITest,n)
hits=0;
inverse_pos=0;
total_test=length(ITest(:,1));
for i=1:total_test,
    [~,pos,val]=find(ITrain(ITest(i,1),1:n)==ITest(i,2));
    if val>0,
        hits=hits+1;
        inverse_pos=inverse_pos + 1/pos;
    end %if
end %for
hr=hits/total_test;
ar=inverse_pos/total_test;
end %function