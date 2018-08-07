#
# Makefile -- build images for chapter 6
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	zeitgl.pdf dreieck.pdf trigosum.pdf dreieck2.pdf spektrum.pdf \
	fftaufwand.pdf

zeitgl.pdf:	zeitgl.tex
	pdflatex zeitgl.tex

dreieck.pdf:	dreieck.tex triangle.tex
	pdflatex dreieck.tex

triangle.tex:	beispiel.m
	octave beispiel.m

trigosum.pdf:	trigosum.tex
	pdflatex trigosum.tex

dreieck2.pdf:	dreieck2.tex
	pdflatex dreieck2.tex

sp.tex:	spektrum.m
	octave spektrum.m

spektrum.pdf:	spektrum.tex sp.tex
	pdflatex spektrum.tex

fftaufwand.pdf:	fftaufwand.tex auf.tex
	pdflatex fftaufwand.tex

auf.tex:	auf.m
	octave auf.m
