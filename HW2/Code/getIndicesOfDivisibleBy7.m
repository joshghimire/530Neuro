function [outputVector] = getIndicesOfDivisibleBy7(vectorV)
    outputVector = find(mod(vectorV,7) == 0);     %find indices of vectorV where there are no remainders after dividing by 7 (can be divided by 7)
end