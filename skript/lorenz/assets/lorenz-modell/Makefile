#
# Makefile fix bounding box for 
#
# (c) 2018 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
images:	lorenz09.pdf lorenz10.pdf

lorenz09.pdf:	lorenz09.eps
	epstool --copy --bbox lorenz09.eps lorenz09.bbox.eps
	epstopdf lorenz09.bbox.eps lorenz09.pdf

lorenz10.pdf:	lorenz10.eps
	epstool --copy --bbox lorenz10.eps lorenz10.bbox.eps
	epstopdf lorenz10.bbox.eps lorenz10.pdf
