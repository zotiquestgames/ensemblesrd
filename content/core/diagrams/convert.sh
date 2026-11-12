#!/bin/bash
# Ensemble diagrams in the house style of Loner 4e (docs/core/diagrams):
# Graphviz -> sketchviz (hand-drawn SVG) -> Inkscape (text to paths, PNG
# 2000 px wide). Same pipeline and settings as docs/core/diagrams/convert.sh;
# rules in docs/core/diagrams/STYLE_GUIDE.md.
# Needs: Graphviz, Node with the packages of _scripts/sketchviz-master
# (npm install there), Inkscape, and Permanent Marker installed as a font.
# Usage: ./convert.sh            all .dot files in this folder
#        ./convert.sh name.dot   one file
cd "$(dirname "$0")"
dir=$(pwd)
sketch="$dir/../../../../_scripts/sketchviz-master"
files=("$@")
[ ${#files[@]} -eq 0 ] && files=(*.dot)
for file in "${files[@]}"
do
    f=$(basename "${file%.*}")
    # sketch.js watches the input after writing the SVG: stop it after the write
    (cd "$sketch" && timeout 30 node sketch.js "$dir/$f.dot" "$dir/$f.svg" >/dev/null)
    inkscape --actions="select-by-element:text;object-to-path" --export-area-drawing \
        --export-background=white --export-filename="$dir/$f.png" --export-width=2000 "$dir/$f.svg" 2>/dev/null
    echo "$f.png"
done
