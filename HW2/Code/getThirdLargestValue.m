function [thirdLargestValue] = getThirdLargestValue(vectorV)
    sortAscendingOrder = sort(vectorV);
    thirdLargestValue = sortAscendingOrder(end-2);
end