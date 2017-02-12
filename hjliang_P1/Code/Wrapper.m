function [ output_args ] = Wrapper( string_list )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
img1 = imread('../Images/Set3/2.jpg');
img2 = imread('../Images/Set3/3.jpg');
img_new = stitch(img1, img2, 'Pyramid');
imshow(img_new);

end

