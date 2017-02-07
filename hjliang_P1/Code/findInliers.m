function [ inliers ] = findInliers( X, Y, x, y, h, thres )
%Find the inliers with error less than thres
%   X, Y : target
%   x, y : input
%   h    : homography transform
%   thres: threshold

[X_h, Y_h] = arrayfun(@(x, y) apply_homography(h, x, y), x, y);
ssd = (X_h - X).^2 + (Y_h - Y).^2;
inliers = find(ssd < thres);

end

