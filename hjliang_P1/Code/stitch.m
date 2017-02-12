function [ outputImg ] = stitch( img1, img2, blend )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

img1 = im2double(img1);
img2 = im2double(img2);
% img1 = cylindricalProj(im2double(img1), 2000);
% img2 = cylindricalProj(im2double(img2), 2000); 
img1_gray = im2double(rgb2gray(img1));
img2_gray = im2double(rgb2gray(img2));
c1 = cornermetric(img1_gray);
c2 = cornermetric(img2_gray);
[row1, col1] = ANMS(c1, 400);
[row2, col2] = ANMS(c2, 400);
% imshow(img1)
% hold on
% plot(col1, row1, 'r+')
% hold off
% keyboard
% imshow(img2)
% hold on
% plot(col2, row2, 'r+')
% hold off
% keyboard
features1 = getFeatures(img1_gray, row1, col1);
features2 = getFeatures(img2_gray, row2, col2);
matchedIndex = matchFeatures(features1, features2, 0.7);
mR1 = row1(matchedIndex(:, 1));
mC1 = col1(matchedIndex(:, 1));
m1 = [mC1 mR1];
mR2 = row2(matchedIndex(:, 2));
mC2 = col2(matchedIndex(:, 2));
m2 = [mC2 mR2];
dispMatchedFeatures(img1, img2, m1, m2, 'montage');
h = myRANSAC(mC1, mR1, mC2, mR2, 1000, 0.9, 2);

% img1 = cylindricalProj(im2double(img1), 2000);
% img2 = cylindricalProj(im2double(img2), 2000);
img2ref = imref2d(size(img2));
[img2_new, img2ref] = imwarp(img2, img2ref, projective2d(h'));
% need to find the world coordinate
% if there are multiple images, need to find the minimum and maximum
xLimits = [min(1, img2ref.XWorldLimits(1)) max(size(img1, 2), img2ref.XWorldLimits(2))];
yLimits = [min(1, img2ref.YWorldLimits(1)) max(size(img1, 1), img2ref.YWorldLimits(2))];
width = ceil(xLimits(2) - xLimits(1));
height = ceil(yLimits(2) - yLimits(1));
% define output image coordinate
out = imref2d([height width], xLimits, yLimits);
img1ref = imref2d(size(img1));
[img1_new, img1ref] = imwarp(img1, img1ref, projective2d(eye(3)), 'OutputView', out);
[img2_new, img2ref] = imwarp(img2, imref2d(size(img2)), projective2d(h'), 'OutputView', out);

mask1 = createMask(img1);
mask1ref = imref2d(size(mask1));
[mask1_new, ~] = imwarp(mask1, mask1ref, projective2d(eye(3)), 'OutputView', out);
mask2 = createMask(img2);
mask2ref = imref2d(size(mask2));
[mask2_new, ~] = imwarp(mask2, mask2ref, projective2d(h'), 'OutputView', out);
% mask1_new = round(mask1_new);
% mask2_new = round(mask2_new);
mask = mask1_new ./ (mask1_new + mask2_new);
mask(mask1_new == 0) = 0;

if strcmp(blend, 'Feather')
    img_new = mask .* img1_new + (1 - mask) .* img2_new;
elseif strcmp(blend, 'Max')
    img_new = max(img1_new, img2_new);
elseif strcmp(blend, 'Average')
    img_new = averageBlend(img1_new, img2_new);
else
    img_new = pyramidBlend(img1_new, img2_new, mask);
end

% imshow(img_new);
outputImg = img_new;

end

