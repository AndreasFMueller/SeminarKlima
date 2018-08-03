#
# Makefile -- build images for chapter 6
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	zeitgl.pdf dreieck.pdf trigosum.pdf dreieck2.pdf

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
