function result=hybridDistribution(source, mask, number,exceptvalue)
mask = spones(mask);
    [a,b]=size(source);
    if a>1&&b>1
        source=reshape(source,a*b,1);
        mask = reshape(mask,a*b,1);
    end
    a=length(exceptvalue);
    if a>0
        for i=1:a
            pp = find(source==exceptvalue(i));
            source(pp)=[];
            mask(pp)=[];
        end
    end
    a=min(source);
    b=max(source);
%     b = 1.2; % 这样做不一定会好但是可以对recall差的进行调整
    step=(b-a)/number;

    column1= [a:step:b]';
    column1(1,:)=[];% 这里默认第一个bin是大于0的bin的，也就是默认去掉0
    train_pre = source(mask==1);
    non_pre = source(mask==0);
    for i =1:1:length(column1)
        if(i==1)
            column3(i)= length(train_pre(train_pre>=0 & train_pre<column1(i)));
            column4(i)= length(non_pre(non_pre>=0 & non_pre<column1(i)));
        else
            if(i==length(column1))
                column3(i)= length(train_pre(train_pre>=column1(i-1) & train_pre<=column1(i)));
                column4(i)= length(non_pre(non_pre>=column1(i-1) & non_pre<=column1(i)));
            else
                column3(i)= length(train_pre(train_pre>=column1(i-1) & train_pre<column1(i)));
                column4(i)= length(non_pre(non_pre>=column1(i-1) & non_pre<column1(i)));
            end
        end
    end
    column2 = column3+column4;
    column5 = column3./nnz(mask);
    column6 = column4./nnz(~mask);
    column5(isnan(column5))=0;
    column5(isinf(column5))=0;
    column6(isnan(column6))=0;
    column6(isinf(column6))=0;
    result=[column1,column2',column3',column4',column5',column6'];
end