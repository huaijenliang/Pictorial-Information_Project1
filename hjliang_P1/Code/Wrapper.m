function [ output_args ] = Wrapper( string_list )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
img1 = imread('../Images/Set1/1.jpg');
img2 = imread('../Images/Set1/2.jpg');
img1_gray = im2double(rgb2gray(img1));
img2_gray = im2double(rgb2gray(img2));
c1 = cornermetric(img1_gray);
c2 = cornermetric(img2_gray);
[x1, y1] = ANMS(c1, 100);
[x2, y2] = ANMS(c2, 100);
features1 = getFeatures(img1_gray, x1, y1);
features2 = getFeatures(img2_gray, x2, y2);
matchedIndex = matchFeatures(features1, features2, 0.5);
mX1 = x1(matchedIndex(:, 1));
mY1 = y1(matchedIndex(:, 1));
mC1 = [mX1 mY1];
mX2 = x2(matchedIndex(:, 2));
mY2 = y2(matchedIndex(:, 2));
mC2 = [mX2 mY2];
dispMatchedFeatures(img1, img2, mC1, mC2);
end

