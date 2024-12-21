#!/bin/sh
# Stop execution of script if a command or pipeline has an error
set -e

# This script requires a modern version of ImageMagick installed (v7 or later)
magick_command="magick"
if ! command -v "$magick_command" 2>&1 >/dev/null
then
    echo "${magick_command} was not found."
    echo "On MacOS, install with 'brew install imagemagick'"
    exit 1
fi

# Set a default icon source file if none passed in environment.
# This source file should have fairly large dimensions such as 600x600
ICON_SOURCE="${ICON_SOURCE:-icon.png}"

echo "Creating favicon.ico..."
$magick_command ${ICON_SOURCE} -alpha off -define icon:auto-resize=256,128,64,48,32,24,16 favicon.ico

echo "Creating PNG icons..."
$magick_command ${ICON_SOURCE} -units PixelsPerInch -density 300 -resize 512x512 android-chrome-512x512.png
$magick_command ${ICON_SOURCE} -units PixelsPerInch -density 300 -resize 192x192 android-chrome-192x192.png
$magick_command ${ICON_SOURCE} -units PixelsPerInch -density 300 -resize 180x180 apple-touch-icon.png
echo "Done!"
