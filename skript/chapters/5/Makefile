#
# Makefile -- build images
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	tikzimages 3dimages

tikzimages:	ein.pdf ein1.pdf halb.pdf total.pdf ell2.pdf bilanzmodell.pdf \
	bifurkation.pdf

ein.pdf:	ein.tex
	pdflatex ein.tex

ein1.pdf:	ein1.tex
	pdflatex ein1.tex

halb.pdf:	halb.tex
	pdflatex halb.tex

ein.txt:	ein.maxima
	maxima -b ein.maxima

total.pdf:	total.tex insolation.tex
	pdflatex total.tex

bilanzmodell.pdf:	bilanzmodell.tex
	pdflatex bilanzmodell.tex

bifurkation.pdf:	bifurkation.tex
	pdflatex bifurkation.tex

insolation.tex:	ein.m
	octave ein.m

ell2.pdf:	ell2.tex elltheta.tex
	pdflatex ell2.tex
elltheta.tex:	ell2.m
	octave ell2.m

3dimages:	earth.png midday.jpg

earth.png:	earth.pov
	povray +A0.1 -W1920 -H1080 -Oearth.png earth.pov

midday.png:	midday.pov daycommon.inc ball.inc
	povray +a01. -W1920 -H860 -Omidday.png midday.pov
midday.jpg:	midday.png
	convert midday.png -density 300 -units PixelsPerInch midday.jpg

