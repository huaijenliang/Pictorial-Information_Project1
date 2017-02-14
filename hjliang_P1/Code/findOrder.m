function [ orderedIndex, h ] = findOrder( images, inliersThreshold, matchRatio )
%UNTITLED2 Summary of this function goes here
%   orderedIndex: a 1XP cell array, where P is # of panaroma sets, and each
%   cell is ordered index for the panaroma
%   H           : a 1XP cell array, where P is # of panaroma sets, and each
%   cell is a NxN cell array contains homography{i, j} (h transforms i onto
%   j)

imagesNum = numel(images);
rows = cell(1, imagesNum);
cols = cell(1, imagesNum);
features = cell(1, imagesNum);
links = zeros(imagesNum, imagesNum);
H = cell(imagesNum, imagesNum);
flags = zeros(1, imagesNum);

% find features
for i = 1:imagesNum
    img_gray = im2double(rgb2gray(images{i}));
    c = cornermetric(img_gray);
    [rows{i}, cols{i}] = ANMS(c, 400);
    features{i} = getFeatures(img_gray, rows{i}, cols{i});
end

% find homography and construct graph
for i = 1:(imagesNum - 1)
    for j = (i + 1):imagesNum
        matchedIndex = matchFeatures(features{i}, features{j}, matchRatio);
        if size(matchedIndex, 1) < 10
            % no enough match found
            disp('Feature match is not enough');
            continue;
        end
        mR1 = rows{i}(matchedIndex(:, 1));
        mC1 = cols{i}(matchedIndex(:, 1));
        m1 = [mC1 mR1];
        mR2 = rows{j}(matchedIndex(:, 2));
        mC2 = cols{j}(matchedIndex(:, 2));
        m2 = [mC2 mR2];
%         dispMatchedFeatures(images{i}, images{j}, m1, m2, 'montage');
        [h, inliersRatio] = myRANSAC(mC1, mR1, mC2, mR2, 10000, 0.9, 2);
        if inliersRatio > inliersThreshold && cond(h) < 1E6 % check if h is singular
            links(i, j) = 1;
            links(j, i) = 1;
            H{i, j} = h;
            H{j, i} = inv(h);
            disp(strcat(int2str(i), ' and ', int2str(j), ' are connected.'))
        end
    end
end

% DFS
panaromaNum = 0;
orderedIndex = cell(1, imagesNum);
h = cell(1, imagesNum);
for i = 1:imagesNum
    if flags(i) == 0
        [list, flags, h_list] = bfs(i, links, flags, H);
        panaromaNum = panaromaNum + 1;
        orderedIndex{panaromaNum} = list;
        h{panaromaNum} = h_list;
    end
end

orderedIndex = orderedIndex(1:panaromaNum);
h = h(1:panaromaNum);

disp('Find images order done')

end

