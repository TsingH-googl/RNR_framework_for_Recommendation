function output = dat2normal( filename,ss)
%% ��������MovieLens�еĲ���������ת��Ϊ����Ŀ��Դ�������ݣ�ssΪ�ָ��ǵ��ַ�
    output = importdata(filename,ss,0); % importdata���ڲ��������ݶ���(�����С�::������������)��load���ڹ������ݶ���
end
