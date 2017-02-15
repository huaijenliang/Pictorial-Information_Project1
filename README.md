# Pictorial-Information_Project1

To stitch images inside a folder, simply call function
[ outputImg ] = myWrapper( path, inliersRatio, matchRatio, f )
	path      = the string of the folder's path
	f         = focal length for cylindrical projection (0 means no projection)
	inliersRatio = ratio of inliers to determine whether two images are connected or not
	matchRatio = ratio for determining whether two features are match or not
	outputImg = a 1 x N cell array contains N panoramas, each entry is a panorama image

Or
[ output ] = Wrapper( files )
	files  = list of the image file names
	output = output panorama

Parameters for each image set
% set 1 0.3, 0.3 900
% set 2 0.3, 0.3 800
% set 3 0.2, 0.2 700
% custom set 1 0.3 0.3 700
% custom set 2 0.3 0.2 700
% test set 1 0.3 0.3 700
% test set 2 0.3 0.2 1
% test set 3 0.3 0.2 1000
% test set 4 0.3 0.3 1000