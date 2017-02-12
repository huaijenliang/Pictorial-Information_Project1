function [ mask ] = createMask( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[rows, cols, channels] = size(img);
[X, ~] = meshgrid(1:cols, 1:rows);
x_center = floor(cols / 2);
X = 1.0 - (abs(x_center - X) ./ x_center);
mask = repmat(X, 1, 1, channels);

end

