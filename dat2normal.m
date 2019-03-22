function output = dat2normal( filename,ss)
%% 把类似于MovieLens中的不规则数据转化为规则的可以处理的数据，ss为分割标记的字符
    output = importdata(filename,ss,0); % importdata用于不规则数据读入(例如有“::”间隔，很灵活)，load用于规则数据读入
end
