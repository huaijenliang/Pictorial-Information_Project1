# Pictorial-Information_Project1

To stitch images inside a folder, simply call function
[ outputImg ] = Wrapper( path, f )
	path      = the string of the folder's path
	f         = focal length for cylindrical projection (0 means no projection)
	outputImg = a 1 x N cell array contains N panoramas, each entry is a panorama image 