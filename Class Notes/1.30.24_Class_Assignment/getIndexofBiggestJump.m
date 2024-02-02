%function [idexOfBiggestJump] = getIndexofBiggestJump(vectorV)
%    for i = 1:length(vectorV)
%end

vectorV = [10 11 12 13 14 18 10];
for i = 1:length(vectorV)
    difference = diff(vectorV);
    for j = 1:length(difference)
        if difference(j) > 1
            greaterThanOneDiff(j)= difference(j);
        end    
    end
end


