function writeMatrix2TXT( A ,path)
% �Ѷ�ά�������������д�뵽txt�ļ���

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

