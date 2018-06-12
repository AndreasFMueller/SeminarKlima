#!/usr/bin/env bash

CURRENTDIR=`pwd`

if [ -z "$1" ]
  then
    echo "No argument supplied. Please pass the order for which the system shold be solved."
    exit
fi

cd maxima && ./generate_octave_func.sh ${1}
cd ${CURRENTDIR}
cd lorenzN && ./solve_system.sh ord${1}
cd ${CURRENTDIR}

