function [ output ] = averageBlend( img1, img2 )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
mask1 = double(rgb2gray(img1) > 0);
mask2 = double(rgb2gray(img2) > 0);
mask = mask1 + mask2;
% mask_tmp = 1 ./ mask;
% mask_tmp(mask == 0) = 0;
mask(mask == 2) = 0.5;
mask = repmat(mask, 1, 1, size(img1, 3));

output = mask .* img1 + mask .* img2;
output(output > 1) = 1;
output(output < 0) = 0;
end

