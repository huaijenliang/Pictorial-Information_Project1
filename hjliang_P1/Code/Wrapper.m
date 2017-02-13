function [ outputImg ] = Wrapper( path )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
files = dir(strcat(path, '*.jpg'));
imagesNum = length(files);
images = cell(1, imagesNum);
for i = 1:imagesNum
    fileName = strcat(path, files(i).name);
    images{i} = imread(fileName);
end

% [orderedIndex, H] = findOrder(images);
% panaromaNum = numel(orderedIndex);
% outputImg = cell(1, panaromaNum);
% for p = 1:panaromaNum
%     rigidIndex = orderedIndex{p}(1);
%     outputImg{p} = images{rigidIndex};
%     outputRef = imref2d(size(outputImg{p}));
%     for i = 2:length(orderedIndex{p})
%         index = orderedIndex{p}(i);
%         h = H{p}{index, rigidIndex};
%         [outputImg{p}, outputRef] = stitchPair(outputImg{p}, images{index}, h, outputRef, 'pyramid');
%     end
% end

img1 = images{1};%imread('../Images/Set3/2.jpg');
img2 = images{2};%imread('../Images/Set3/3.jpg');
img_new = stitch(img1, img2, 'Pyramid');
imshow(img_new);

end

