function [ features ] = getFeatures( img, rows, cols )
%Get 8X8 features for each data point
%   img : input data
%   rows: the vector of the row of the point for getting features from
%   cols: the vector of the col of the point for getting features from
fullDim = 40;
sampleDim = 8;
pointsNum = numel(rows);
features = zeros(pointsNum, sampleDim.^2);
imgSize = size(img);

for i = 1:pointsNum
    x = rows(i);
    y = cols(i);
    down = max(1, (x - fullDim / 2));
    up = min(imgSize(1), (x + fullDim / 2));
    left = max(1, (y - fullDim / 2));
    right = min(imgSize(2), (y + fullDim / 2));
    fullFeats = img(down:up, left:right);
    gaussian = fspecial('gaussian');
    fullFeats = conv2(fullFeats, gaussian, 'same');
    sampleFeats = imresize(fullFeats, [sampleDim sampleDim]);
    sampleFeats = reshape(sampleFeats, 1, []);
    sampleFeats = (sampleFeats - mean(sampleFeats)) / std(sampleFeats);
    features(i, :) = sampleFeats;
end


end

