function [ output ] = cylindricalProj( input, f )
%Project a planar image onto a cylinder
%   input: input image (double)
%   f    : focal length
[rows, cols, channels] = size(input);
[x, y] = meshgrid(1:cols, 1:rows);
x_center = ceil(cols / 2);
y_center = ceil(rows / 2);
xC = f * tan((x - x_center) / f) + x_center;
yC = (y - y_center) ./ cos((x - x_center) / f) + y_center;
% xC = round(xC);
% yC = round(yC);
% Handle out of bound
mask_valid = ((xC >= 1) & (xC <= cols)) & ((yC >= 1) & (yC <= rows));
xC(~mask_valid) = 1;
yC(~mask_valid) = 1;
xC_LU = floor(xC);
yC_LU = floor(yC);
xC_diff = xC - xC_LU;
yC_diff = yC - yC_LU;
index = sub2ind([rows, cols], yC_LU, xC_LU);

output = zeros(rows, cols, channels);
for c = 1:channels
    m = input(:, :, c);
    temp_LU = m(index);
    temp_LD = m(index + 1);
    temp_RU = m(index + rows);
    temp_RD = m(index + rows + 1);
    temp = (1 - yC_diff) .* ((1 - xC_diff) .* temp_LU + xC_diff .* temp_LD) + yC_diff .* ((1 - xC_diff) .* temp_RU + xC_diff .* temp_RD);
    temp(~mask_valid) = 0;
    output(:, :, c) = temp;
end
imshow(output);

end

