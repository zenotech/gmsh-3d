#!/bin/bash

for i in *.geo; do
 gmsh -2 -algo del2d $i
done

# $Id: $


