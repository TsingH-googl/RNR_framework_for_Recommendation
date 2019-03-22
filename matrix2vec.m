function vec = matrix2vec( matrix)

[row, col] = find(matrix);
weight = matrix(matrix>0);
vec = [row, col, weight];
vec = full(vec);
end

