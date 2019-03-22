function FINAL_R = Demo_Test()

data   = load('u.user');
user_id   = data(:,1);
age       = data(:,2);
gender    = data(:,3);
occupation= data(:,4);

m      = length(user_id);
simi   = zeros(m,m);
iter   = 1682;

for p=1:m
    for k=1:m
        if abs(age(k,1)-age(p,1))>10
            dis1=2;
        else
            dis1=0;
        end
        
        if gender(k,1)==gender(p,1)
            dis2=0;
        else
            dis2=2;
        end
        
        if occupation(k,1)==occupation(p,1)
            dis3=0;
        else
            dis3=2;
        end
        
        simi(k,p) = 3-sqrt(dis1^2+dis2^2+dis3^2);
    end
end

data     = load('TrainX4.txt');
user_id = data(:,1);
item_id = data(:,2);
rating  = data(:,3);

x   = length(rating);
Rtg = zeros(m,iter);

for k = 1:x
    Rtg(user_id(k,1),item_id(k,1)) = rating(k,1);
end

FINAL_R = zeros(943,1682);

for p = 1:m,
    for j = 1:iter,
        FINAL_R(p,j) = max(simi(:,p).*Rtg(:,j));
    end %for items
end %for users

FINAL_R = FINAL_R/3;

end %function