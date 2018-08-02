#
# Makefile -- build images for chapter 6
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	zeitgl.pdf dreieck.pdf

zeitgl.pdf:	zeitgl.tex
	pdflatex zeitgl.tex

dreieck.pdf:	dreieck.tex triangle.tex
	pdflatex dreieck.tex

triangle.tex:	beispiel.m
	octave beispiel.m
