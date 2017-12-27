#!/bin/sh

# Substitute your f90 compiler here
F90="gfortran -ffree-line-length-none"

../forpedo.py < dynamicarray.f90t > dynamicarray.f90
$F90 intarray.f90 dynamicarray.f90 main.f90

