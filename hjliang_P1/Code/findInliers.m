function [ inliers ] = findInliers( X, Y, x, y, h, thres )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

[X_h, Y_h] = arrayfun(@(x, y) apply_homography(h, x, y), x, y);
ssd = (X_h - X).^2 + (Y_h - Y).^2;
inliers = find(ssd < thres);

end

