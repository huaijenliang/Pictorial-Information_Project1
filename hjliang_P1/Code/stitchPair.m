function [ outputImg, outRef, outputMask ] = stitchPair( img1, img2, h, img1Ref, img1Mask, blend )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[img2_new, img2Ref] = imwarp(img2, imref2d(size(img2)), projective2d(h'));

% need to find the world coordinate
% if there are multiple images, need to find the minimum and maximum
xLimits = [min(img1Ref.XWorldLimits(1), img2Ref.XWorldLimits(1)) max(img1Ref.XWorldLimits(2), img2Ref.XWorldLimits(2))];
yLimits = [min(img1Ref.YWorldLimits(1), img2Ref.YWorldLimits(1)) max(img1Ref.YWorldLimits(2), img2Ref.YWorldLimits(2))];
width = ceil(xLimits(2) - xLimits(1));
height = ceil(yLimits(2) - yLimits(1));
% define output image coordinate
outRef = imref2d([height width], xLimits, yLimits);

[img1_new, img1Ref] = imwarp(img1, img1Ref, projective2d(eye(3)), 'OutputView', outRef);
[img2_new, img2Ref] = imwarp(img2, imref2d(size(img2)), projective2d(h'), 'OutputView', outRef);

% mask1 = createMask(img1);
% mask1ref = imref2d(size(mask1));
% [mask1_new, ~] = imwarp(mask1, mask1ref, projective2d(eye(3)), 'OutputView', outRef);
mask1ref = imref2d(size(img1Mask));
[mask1_new, ~] = imwarp(img1Mask, mask1ref, projective2d(eye(3)), 'OutputView', outRef);
mask2 = createMask(img2);
mask2ref = imref2d(size(mask2));
[mask2_new, ~] = imwarp(mask2, mask2ref, projective2d(h'), 'OutputView', outRef);
% mask1_new = round(mask1_new);
% mask2_new = round(mask2_new);
outputMask = mask1_new + mask2_new;
mask = mask1_new ./ outputMask;
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

