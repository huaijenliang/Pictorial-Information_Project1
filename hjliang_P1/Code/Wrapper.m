function [ outputImg ] = Wrapper( path )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
files = dir(strcat(path, '*.jpg'));
imagesNum = length(files);
images = cell(1, imagesNum);
for i = 1:imagesNum
    fileName = strcat(path, files(i).name);
    images{i} = imread(fileName);
    images{i} = im2double(images{i});
end

[orderedIndex, H] = findOrder(images, 0.4);
panaromaNum = numel(orderedIndex);
outputImg = cell(1, panaromaNum);
for p = 1:panaromaNum
    rigidIndex = orderedIndex{p}(1);
    if numel(orderedIndex{p}) == 1
        disp(strcat(files(rigidIndex).name, ' is a single image'));
        continue;
    end
    outputImg{p} = images{rigidIndex};
    outputRef = imref2d(size(outputImg{p}));
    for i = 2:length(orderedIndex{p})
        index = orderedIndex{p}(i);
        h = H{p}{i};
        % TODO
        % Blending mask warping
        [outputImg{p}, outputRef] = stitchPair(outputImg{p}, images{index}, h, outputRef, 'Max');
    end
end

imshow(outputImg{1});

% img1 = images{1};%imread('../Images/Set3/2.jpg');
% img2 = images{2};%imread('../Images/Set3/3.jpg');
% img_new = stitch(img1, img2, 'Pyramid');
% imshow(img_new);

end

