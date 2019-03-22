function prop = datasetProp(net_rating)

[userNum, itemNum] = size(net_rating);
link = nnz(net_rating);
rsize = link/userNum;
csize = link/itemNum;
density = (link / (userNum * itemNum)) * 100;
density =  strcat (num2str(density), '%');

rating = max(max(net_rating));

if rating == 1
    rating = '-';
else
    rating = strcat('1-', num2str(rating));
end

prop = strvcat(num2str(userNum), num2str(itemNum), num2str(link), num2str(rsize), num2str(csize), density, rating);
end

