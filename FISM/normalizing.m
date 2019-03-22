function FINAL_WT = normalizing(R_matrix)

[userNum, itemNum] = size(R_matrix);
MAX_WT = zeros(userNum,1);
MAX_WT = max(R_matrix,[],2);

FINAL_WT = sparse(zeros(userNum,itemNum));

for count=1:userNum,
    FINAL_WT(count,:) = R_matrix(count,:)/MAX_WT(count);
end %for