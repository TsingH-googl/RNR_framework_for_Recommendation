%% ����precision��recall�ĺ�һָ��Fmeasure
function out = FM( precisionList, recallList )
out = 2 * ((precisionList.* recallList) ./ (precisionList + recallList));
end

