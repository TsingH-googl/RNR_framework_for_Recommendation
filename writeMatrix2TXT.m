function writeMatrix2TXT( A ,path)
% 把二维矩阵的行列坐标写入到txt文件中

fid=fopen(path,'w');
[b1 b2]=size(A);
for i=1:b1
       fprintf(fid,'%d',A(i,1));
       fprintf(fid,' %d',A(i,2));
       fprintf(fid,' %d',A(i,3));
       fprintf(fid,' %d',A(i,4));
   fprintf(fid,'\r\n');
end
fclose(fid);
end

