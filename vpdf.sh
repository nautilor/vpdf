#!/usr/bin/env bash

# * Error if argument is not provided
[ $# -eq 0 ] && echo "E: Missing filename..." && exit -1

# * Generate a random filename
FILENAME=`echo $RANDOM | md5sum | head -c 20`

# * If the argument is a folder recursively search for image files
if [ -d "$1" ]; then
    convert -compress jpeg `find "$1" -type f -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" | sort` "/tmp/$FILENAME.pdf"
    echo "* File saved as /tmp/$FILENAME.pdf"
    mupdf "/tmp/$FILENAME.pdf"
else 
    # * Check if the argument exists as a file
    [ ! -f "$1" ] && echo "E: File does not exists..." && exit -1
    convert -compress jpeg "$1" "/tmp/$FILENAME.pdf"
    echo "* File saved as /tmp/$FILENAME.pdf"
    mupdf "/tmp/$FILENAME.pdf"
fi

