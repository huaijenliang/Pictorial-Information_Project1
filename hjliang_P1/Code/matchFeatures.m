function [ matchedIndex ] = matchFeatures( features1, features2, ratio )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

n1 = size(features1, 1);
n2 = size(features2, 1);
nMatched = 0;
matchedIndex = zeros(n1, 2);

for i = 1:n1
    f1 = features1(i, :);
    minDiff1 = inf;
    minDiff2 = inf;
    index = 1;
    for j = 1:n2
        f2 = features2(j, :);
        diff = f1 - f2;
        diff = sum(diff.^2);
        if diff < minDiff2
            minDiff2 = diff;
            if diff < minDiff1
                minDiff2 = minDiff1;
                minDiff1 = diff;
                index = j;
            end
        end
    end
    if minDiff1 / minDiff2 < ratio
        nMatched = nMatched + 1;
        matchedIndex(nMatched, :) = [i, index];
    end
end

matchedIndex = matchedIndex(1:nMatched, :);

end

