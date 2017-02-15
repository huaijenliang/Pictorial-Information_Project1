# Pictorial-Information_Project1

To stitch images inside a folder, simply call function
[ outputImg ] = Wrapper( path, f, inliersRatio, matchRatio )
	path      = the string of the folder's path
	f         = focal length for cylindrical projection (0 means no projection)
	inliersRatio = ratio of inliers to determine whether two images are connected or not
	matchRatio = ratio for determining whether two features are match or not
	outputImg = a 1 x N cell array contains N panoramas, each entry is a panorama image 