%% 计算precision与recall的合一指标Fmeasure
function out = FM( precisionList, recallList )
out = 2 * ((precisionList.* recallList) ./ (precisionList + recallList));
end

