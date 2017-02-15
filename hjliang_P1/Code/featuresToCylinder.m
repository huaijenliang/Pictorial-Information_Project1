function [ outR, outC ] = featuresToCylinder( inR, inC, image, f )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[row, col, ~] = size(image);
[x, y] = meshgrid(1:col, 1:row);
x_center = ceil(col / 2);
y_center = ceil(row / 2);
xC = atan((x - x_center) ./ f) .* f + x_center;
yC = (y - y_center) .* cos((x - x_center) / f) + y_center;
mask_valid = ((xC >= 1) & (xC <= col)) & ((yC >= 1) & (yC <= row));
xC(~mask_valid) = 1;
yC(~mask_valid) = 1;
xC_LU = round(xC);
yC_LU = round(yC);
index = sub2ind([row, col], inR, inC);
outR = yC_LU(index);
outC = xC_LU(index);

% map = zeros(size(image, 1), size(image, 2));
% for i = 1:numel(inR)
%     map(inR(i), inC(i)) = 1;
% end
% 
% new_map = cylindricalProj(map, f);
% mask = new_map > 0.25;
% [outR, outC, v] = find(mask);

end

