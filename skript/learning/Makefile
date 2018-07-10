#
# Makefile -- Zusätzliches Material für das Paper erzeugen
#
# (c) 2018 Martin Stypinski, Hochschule Rapperswil
#
all:	images

images:	compmod.pdf burgerwave.pdf

compmod.pdf:	compmod.tex
	pdflatex compmod.tex

burgerwave.pdf:	burgerwave.tex bw.tex
	pdflatex burgerwave.tex

bw.tex:	expl.m
	octave expl.m
