#!/bin/bash

# Check if an HTML file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_html_file> [font_directory]"
  exit 1
fi

HTML_FILE="$1"

# Set the font directory
if [ -n "$2" ]; then
  FONT_DIR="$2"
else
  FONT_DIR="$(dirname "$HTML_FILE")/fonts"
fi

# Create the font directory if it doesn't exist
mkdir -p "$FONT_DIR"

CSS_FILE="$FONT_DIR/fonts.css"

# Check if the fonts CSS file already exists
if [ -f "$CSS_FILE" ]; then
  echo "Fonts CSS file already exists at $CSS_FILE. No action needed."
  exit 0
fi

# Extract the Google Fonts URL from the HTML file
GOOGLE_FONTS_URL=$(grep -oP "https://fonts.googleapis.com/css\?family=[^(\"|')]+" "$HTML_FILE")

# If no match found with https, try matching with protocol-neutral format
if [ -z "$GOOGLE_FONTS_URL" ]; then
        GOOGLE_FONTS_URL=$(grep -oP "//fonts.googleapis.com/css\?family=[^(\"|')]+" "$HTML_FILE")
  # Add https: prefix to the URL
  GOOGLE_FONTS_URL="https:$GOOGLE_FONTS_URL"
fi

if [ -z "$GOOGLE_FONTS_URL" ]; then
  echo "No Google Fonts URL found in the HTML file."
  exit 1
fi

echo "Google Fonts URL: $GOOGLE_FONTS_URL"

# Download the CSS file from Google Fonts
curl -v -o "$CSS_FILE" "$GOOGLE_FONTS_URL"

# Parse and download each font file
grep -oP 'url\(\K[^)]+(?=\))' "$CSS_FILE" | while read -r FONT_URL; do
  # Check if FONT_URL is protocol-neutral and prepend "https:" if needed
  if [[ "$FONT_URL" == //fonts.googleapis.com/* ]]; then
    FONT_URL="https:$FONT_URL"
  fi
  
  FONT_FILE="$FONT_DIR/$(basename "$FONT_URL")"
  echo "Downloading $FONT_URL to $FONT_FILE"
  curl -s "$FONT_URL" -o "$FONT_FILE"
  if [ $? -eq 0 ]; then
    echo "Downloaded $FONT_URL successfully."
    # Replace the URL in the CSS file with the local path
    sed -i "s|$FONT_URL|$FONT_FILE|g" "$CSS_FILE"
  else
    echo "Failed to download $FONT_URL."
  fi
done

# Update the HTML file to use the local CSS file
sed -i "s|$GOOGLE_FONTS_URL|$CSS_FILE|g" "$HTML_FILE"

echo "Fonts have been downloaded and the HTML file has been updated."
