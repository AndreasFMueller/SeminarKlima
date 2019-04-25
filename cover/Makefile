#
# Makefile
#
# (c) 2017 Prof Dr Andreas Müller, Hochschule Rapperswil
#
buchcover.pdf:	buchcover.tex
	pdflatex buchcover.tex

buchcover.png:	buchcover.pdf Makefile
	convert -density 300 -extract 1966x2900+2630+190 buchcover.pdf \
		buchcover.png

buchcover-small.png:	buchcover.png
	convert buchcover.png -resize 50% buchcover-small.png

