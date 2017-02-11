function [ output ] = laplacPyramid( input )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
depth = numel(input);
output = cell(1, depth);

for d = 1:(depth - 1)
    img = input{d + 1};
    img = imresize(img, [size(input{d}, 1), size(input{d}, 2)]);
    output{d} = input{d} - img;
end

output{depth} = input{depth};

end

