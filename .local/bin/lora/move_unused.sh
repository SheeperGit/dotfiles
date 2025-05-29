#!/bin/sh

############################################################################
# Move image to/from the "unused" directory based on its current location. #
############################################################################

# Usage: 
#   move_unused.sh <file>
#   
# Description: 
#   If the current image and its corresponding .txt file are in an "unused" directory 
#   (e.g., path/to/training/unused/lora-name/), then move it back to its original directory 
#   (e.g., path/to/training/lora-name/). Otherwise, move the image and text file to 
#   the "unused" directory (i.e., path/to/training/unused/lora-name), creating the directory
#   if it did not exist.
#
# Examples: 
#   move_unused.sh filename.png   # Apply the move to `filename.png` and `filename.txt`.
#   move_unused.sh filename.jpg   # Apply the move to `filename.jpg` and `filename.txt`.
#   move_unused.sh filename.pdf   # Weird usage, but possible. This script is meant for img/txt filename pairs.

BASE_DIR="$HOME/programs/grabber/training"
UNUSED_DIR="$BASE_DIR/unused"

file="$1"
[ -z "$file" ] && {
  notify-send "$(basename $0) Error" "No file provided to move_unused.sh"
  exit 1
}

if echo "$file" | grep -q "/unused/" ; then
  dst=$(echo "$file" | sed 's#unused/##' | xargs dirname)
else
  dst=$(echo "$file" | sed "s#^$BASE_DIR/#$UNUSED_DIR/#" | xargs dirname)

  # Create unused dir, if it doesn't exist. #
  [ ! -d "$dst" ] && \
    mkdir -p "$dst" && \
    notify-send "Created unused directory: $dst"
fi

mv -vn "$file" "$(echo "$file" | sed 's/\.[^.]*$//').txt" "$dst"/

