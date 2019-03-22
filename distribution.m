function result=distribution (source,number,exceptvalue)
%plot the distribution of source
%source: input data
%number: size of x-axis bins
%exceptvalue: vector of neglectable values
    [a,b]=size(source);
    if a>1&&b>1
        source=reshape(source,a*b,1);
    end
    a=length(exceptvalue);
    if a>0
        for i=1:a
            source(find(source==exceptvalue(i)))=[];
        end
    end
    a=min(source);
    b=max(source);    
    step=(b-a)/number;
    if step==0
        result=[];
    end
    column1=[a:step:b]';
    column2=zeros(size(column1,1),1);
    t1=0;
    for i=1:size(column1,1)        
        t2=length(find(source<=column1(i)));
        column2(i)=t2-t1;
        t1=t2;
        if i==2;
            column2(i)=column2(i)+column2(i-1);
            column2(i-1)=0;
        end
    end
    column3=column2/length(source);
    result=[column1 column2 column3];
    
    
    plot(column1,column2,'*-')
figure
plot(column1,column3,'*-')









