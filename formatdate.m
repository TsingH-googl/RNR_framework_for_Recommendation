function formatdate = formatdate( stampdata )
%% �����ʱ���ת��Ϊ��ÿ������ݽ�������;
%% stampdata�ǰ���ʱ������ź��򡯵�ʱ��
    stampdata = stampdata - stampdata(1) + 1;
    formatdate = int32(stampdata/(3600*24)) + 1; % ת��Ϊ�ӵ�һ�쿪ʼ���㣬��Ϊ�Ҿ����û���ÿһ��İ��ã��Ѿ����Է�ӳ���ǵ���Ϊ��Ϣ��
end

