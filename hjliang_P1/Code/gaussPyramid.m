function [ output ] = gaussPyramid( input, depth )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

output = cell(1, depth);
output{1} = input;
% a = 0.4;
% w_1d = [0.25 - a/2 0.25 a 0.25 0.25 - a/2];
% gaussian = w_1d' * w_1d;
gaussian = fspecial('gaussian', 5, 3);

for d = 2:depth
    img = output{d - 1};
    img = imfilter(img, gaussian, 'conv', 'same');%, 'replicate');
    output{d} = imresize(img, 0.5);
end

end

