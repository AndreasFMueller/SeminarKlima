#!/usr/bin/env bash

LORENZFILE=lorenzN.maxima
OUTFILE=lorenz_diff.m
TEMPFILE=.tmp.m
OCTAVEFILES=*.m
OCTAVELORENZFOLDER=../lorenzN/

rm -f ${OUTFILE}
order=$1 maxima -b ${LORENZFILE}
sed '/^dX(/ s/$/;/' ${OUTFILE} > ${TEMPFILE}
mv ${TEMPFILE} ${OUTFILE}
mv ${OCTAVEFILES} ${OCTAVELORENZFOLDER}