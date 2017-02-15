function [ panorama ] = Wrapper( files )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
imagesNum = length(files);
images = cell(1, imagesNum);
for i = 1:imagesNum
    fileName = files(i);
    images{i} = imread(fileName);
    images{i} = im2double(images{i});
%     images{i} = cylindricalProj(images{i}, 600);
end
% set 1 0.3, 0.3 900
% set 2 0.3, 0.3 800
% set 3 0.2, 0.2 700
% custom set 1
% custom set 2 0.3 0.2 700
% test set 1
% test set 2 0.3 0.2 1
% test set 3 0.3 0.2 1000
% test set 4 0.3 0.3 1000
inliersRatio = 0.3;
matchRatio = 0.3;
f = 800;
[orderedIndex, H] = findOrder(images, inliersRatio, matchRatio, f);
panaromaNum = numel(orderedIndex);
outputImg = cell(1, panaromaNum);
% for i = 1:imagesNum
%     images{i} = cylindricalProj(images{i}, 600);
% end
for p = 1:panaromaNum
    rigidIndex = orderedIndex{p}(1);
    if numel(orderedIndex{p}) == 1
        disp(strcat(files(rigidIndex).name, ' is a single image'));
        continue;
    end
    outputImg{p} = images{rigidIndex};
    outputRef = imref2d(size(outputImg{p}));
    outputMask = createMask(outputImg{p});
    for i = 2:length(orderedIndex{p})
        index = orderedIndex{p}(i);
        h = H{p}{i};
        % TODO
        % Blending mask warping
        [outputImg{p}, outputRef, outputMask] = stitchPair(outputImg{p}, images{index}, h, outputRef, outputMask, 'Pyramid');
        disp(strcat('Blending', int2str(rigidIndex), ' and ', int2str(index), ' done.'))
%         imshow(outputImg{p});
    end
    panorama = outputImg{p};
end

% imshow(outputImg{1});

% img1 = images{1};%imread('../Images/Set3/2.jpg');
% img2 = images{2};%imread('../Images/Set3/3.jpg');
% img_new = stitch(img1, img2, 'Pyramid');
% imshow(img_new);

end

