clear all;
%% ��ȡѵ��������
%% ǧ��Ҫ�ظ�д�����ݣ���������
trainName =char('u1.base', 'u2.base', 'u3.base', 'u4.base','u5.base');
saveName =  char('u1base.txt', 'u2base.txt', 'u3base.txt', 'u4base.txt','u5base.txt');
filepath = 'D:\��·Ԥ����ؿ���\�����û�-��Ʒ���Ƽ�\ʱ����������Ϣ���ݼ�\MovieLens\ml-100k\';
savepath = 'D:\ml100k\';
for i = 1:1:5
     train = (load(strcat(filepath,trainName(i,:))));
     train = sortrows(train , 1);
     A = [train(:,1), train(:,2)];
     writeMatrix2TXT(A, strcat(savepath , saveName(i,:))  );
end
