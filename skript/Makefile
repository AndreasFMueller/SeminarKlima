#
# Makefile zum Skript ueber den Klimawandel
#
# (c) 2017 Prof Dr Andreas Mueller, Hochschule Rapperswil
#
all:	skript.pdf

#SUBDIRECTORIES = chapters uebungsaufgaben 
SUBDIRECTORIES = chapters

.PHONY:	images

images:
	for d in $(SUBDIRECTORIES); \
	do \
		(cd $${d}; make images); \
	done

CHAPTERS = 								\
	chapters/part1.tex						\
	chapters/assim.tex						\
	chapters/dgl.tex						\
	chapters/elnino.tex						\
	chapters/fourier.tex						\
	chapters/thc.tex						\
	chapters/wuk.tex						\
	chapters/1/klima.tex						\
	chapters/1/physik.tex						\
	chapters/1/anforderungen.tex					\
	chapters/fluiddynamik.tex					\
	chapters/zonen.tex						\
	chapters/2/hydrodynamik.tex					\
	chapters/2/lorenz.tex						\
	chapters/2/aufgabe1.tex						\
	chapters/2/aufgabe2.tex						\
	chapters/2/aufgabe3.tex						\
	chapters/3/crit.tex						\
	chapters/3/dgl.tex						\
	chapters/3/aufgabe1.tex						\
	chapters/4/salinitaet.tex					\
	chapters/4/box.tex						\
	chapters/4/dimensionslos.tex					\
	chapters/6/periodisch.tex					\
	chapters/6/fourierkoef.tex					\
	chapters/6/vektorgeometrie.tex					\
	chapters/6/aufgabe1.tex

PAPERDIRS = eis extrem lorenz planeten thermohalin vegetation		\
	verzoegert lorenz2 kalman learning

PAPERFILES =								\
	eis/main.tex							\
	eis/references.bib						\
	eis/packages.tex						\
	eis/Makefile							\
	extrem/main.tex							\
	extrem/references.bib						\
	extrem/packages.tex						\
	extrem/Makefile							\
	lorenz/main.tex							\
	lorenz/references.bib						\
	lorenz/packages.tex						\
	lorenz/Makefile							\
	neigung/main.tex						\
	neigung/references.bib						\
	neigung/packages.tex						\
	neigung/Makefile						\
	planeten/main.tex						\
	planeten/references.bib						\
	planeten/packages.tex						\
	planeten/Makefile						\
	thermohalin/main.tex						\
	thermohalin/references.bib					\
	thermohalin/packages.tex					\
	thermohalin/Makefile						\
	vegetation/main.tex						\
	vegetation/references.bib					\
	vegetation/packages.tex						\
	vegetation/Makefile						\
	verzoegert/main.tex						\
	verzoegert/references.bib					\
	verzoegert/packages.tex						\
	verzoegert/Makefile						\
	lorenz2/main.tex						\
	lorenz2/references.bib						\
	lorenz2/packages.tex						\
	lorenz2/Makefile						\
	kalman/main.tex							\
	kalman/references.bib						\
	kalman/packages.tex						\
	kalman/Makefile							\
	learning/main.tex						\
	learning/references.bib						\
	learning/packages.tex						\
	learning/Makefile

SKRIPTFILES = teilnehmer.tex vorwort.tex uebersicht.tex \
	$(CHAPTERS) \
	references.bib \
	$(PAPERFILES)

THEMA_FILES = 								\

TEXFILES = $(SKRIPTFILES) \
	$(THEMA_FILES)

BLXFILES = \
	skript.bbl \
	skript1-blx.bbl \
 	skript2-blx.bbl \
	skript3-blx.bbl \
	skript4-blx.bbl \
	skript5-blx.bbl \
	skript6-blx.bbl \
	skript7-blx.bbl \
	skript8-blx.bbl \
	skript9-blx.bbl \
	skript10-blx.bbl \
	skript11-blx.bbl \
	skript12-blx.bbl

skript.pdf:	skript.tex $(TEXFILES) skript.ind $(BLXFILES)
	pdflatex skript.tex
	bibtex skript

skript.idx:	skript.tex $(TEXFILES) images
	touch skript.ind
	pdflatex skript.tex

skript.ind:	skript.idx
	makeindex skript.idx

# References

skript.bbl:		skript.aux
	bibtex skript

skript1-blx.bbl:	skript1-blx.aux
	bibtex skript1-blx

skript2-blx.bbl:	skript2-blx.aux
	bibtex skript2-blx

skript3-blx.bbl:	skript3-blx.aux
	bibtex skript3-blx

skript4-blx.bbl:	skript4-blx.aux
	bibtex skript4-blx

skript5-blx.bbl:	skript5-blx.aux
	bibtex skript5-blx

skript6-blx.bbl:	skript6-blx.aux
	bibtex skript6-blx

skript7-blx.bbl:	skript7-blx.aux
	bibtex skript7-blx

skript8-blx.bbl:	skript8-blx.aux
	bibtex skript8-blx

skript9-blx.bbl:	skript9-blx.aux
	bibtex skript9-blx

skript10-blx.bbl:	skript10-blx.aux
	bibtex skript10-blx

skript11-blx.bbl:	skript11-blx.aux
	bibtex skript11-blx

skript12-blx.bbl:	skript12-blx.aux
	bibtex skript12-blx

clean:	cleansubdir
	rm -f *.bbl *.aux *.log *.out *.run.xml *.pdf *.blg *.idx *.ind \
		*.ilg *.toc *.synctex.gz *.auxlock *.bak *-blx.bib *.dvi

cleansubdir:
	for d in $(SUBDIRECTORIES); \
	do \
		cd $${d}; make clean; cd ..; \
	done
