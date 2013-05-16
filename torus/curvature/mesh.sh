#!/bin/bash

for i in 0*.geo; do
 gmsh -2 -algo del2d $i
 #gmsh -2 -algo frontal2d $i
done

# $Id: $


