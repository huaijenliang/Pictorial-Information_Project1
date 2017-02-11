function [ output ] = pyramidBlend( first, second, mask )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

first = im2double(first);
second = im2double(second);
mask = double(mask);

minSize = min([size(first, 1), size(first, 2)]);
depth = floor(log2(minSize)) - 4;
gaussFirst = gaussPyramid(first, depth);
gaussSecond = gaussPyramid(second, depth);
gaussMask = gaussPyramid(mask, depth);

laplacFirst = laplacPyramid(gaussFirst);
laplacSecond = laplacPyramid(gaussSecond);

laplacBlend = blendHelp(laplacFirst, laplacSecond, gaussMask);

output = collapseLaplac(laplacBlend);

output(output < 0) = 0;
output(output > 1) = 1;

end

