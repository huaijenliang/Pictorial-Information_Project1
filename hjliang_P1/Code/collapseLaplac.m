function [ output ] = collapseLaplac( inputLaplac )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

depth = numel(inputLaplac);
prevImg = inputLaplac{depth};
for d = (depth - 1):-1:1
    prevImg = imresize(prevImg, [size(inputLaplac{d}, 1), size(inputLaplac{d}, 2)]);
    prevImg = prevImg + inputLaplac{d};
end

output = prevImg;

end

