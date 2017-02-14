function [ h, ratioOut ] = myRANSAC( X, Y, x, y, maxIter, inlierRatio , thres )
%Running RANSAC to find the best homography
%   X, Y : target
%   x, y : input
%   thres: The threshold for determining the inliers
iter = 0;
numData = numel(X);
h = 0;
inliers = [];
ratioOut = 0.0;

while iter < maxIter
    r = randperm(numData, 4);
    h_new = est_homography(X(r), Y(r), x(r), y(r));
    inliers_new = findInliers(X, Y, x, y, h_new, thres);
    if numel(inliers_new) > numel(inliers)
        inliers = inliers_new;
        h = h_new;
        ratioOut = double(numel(inliers) / numData);
    end
    if (numData * inlierRatio) < numel(inliers)
        disp('Find match')
        break;
    end
    iter = iter + 1;
end

end

