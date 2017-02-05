function [ h ] = myRANSAC( X, Y, x, y, maxIter, inlierRatio )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
iter = 0;
numData = numel(X);
h = 0;
inliers = [];

while iter < maxIter
    r = randperm(numData, 4);
    h_new = est_homography(X(r), Y(r), x(r), y(r));
    inliers_new = findInliers(X, Y, x, y, h_new, 100);
    if numel(inliers_new) > numel(inliers)
        inliers = inliers_new;
        h = h_new;
    end
    if (numData * inlierRatio) < numel(inliers)
        break;
    end
    iter = iter + 1;
end


end

