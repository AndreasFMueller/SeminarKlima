#!/usr/bin/env bash

octave lorenz.m

mv timing.m ${1}.timing.m
mv lorenz_ic.m ${1}.lorenz_ic.m
mv X.m ${1}.X.m
mv X.eps ${1}.X.eps
mv butterfly.eps ${1}.butterfly.eps
